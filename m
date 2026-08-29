Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E20C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C9510E69F;
	Mon, 31 Aug 2026 07:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="U8PAjo/w";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932010E0B0
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 07:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787987655; x=1788246855;
 bh=kIk2FnWRFYjt/MDZYqqCEVVosV9asFtRnc86uQg83HE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=U8PAjo/wBQ1UzYjVgRkZqrFOqOzTX6iFQDOIYTbkEXwUope6eEsU4eTxbJVfSuNkU
 EOmKWHkKdQ+n5NMeieFPFK50n8eN+Hq4GFzbEdqbvoz5tmQ+l9Lg3TCXldkxhxxFoC
 asne6BLSX2Pl7HXzQNrWNVHkO+jxfeWMuU5Qm3OFCLM6ZtavX4TwbG3KOgmRlZ+X8g
 S+oz8aIMzy0ww1lQPxHSNIYtgN9sCfE5PvXryQCqSGjfl5igDMoVr9+0EfJbEMgwq2
 CBWU0K51ZMT9Ofh7PgMx/0/fJyNb/5lDxrD6ZrSufM1AveldeMu510H7e9b9hKXG7f
 nZ2aE798KGFNA==
Date: Sat, 29 Aug 2026 07:14:10 +0000
To: "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
From: nirbhayykumarr@proton.me
Cc: "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: [BUG] misc/mei: Race between mei_release() disconnect and
 mei_ioctl_connect_vtag() causes CSME reset storm and i915 freeze
Message-ID: <HVTY6-E6fK5xolgZqI7bt1JIKctxL4VdcbteGTvPo7PN58iyvU01QXToLr2v9pvJtGTrUHFLuc7xZQtplf6HaZak1JvG3gySDpazMhbHsnE=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 8104cc690dd5055df13bcefbadcdbe3ede1aa86a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi all,

This issue was discovered using a custom multi-threaded C fuzzer
designed to stress-test MEI Virtual Tag (vtag) client lifecycles and
multiplexing over /dev/mei0. By concurrently racing rapid vtag
connections against file descriptor closures and streaming I/O, a
race condition is triggered during client teardown.

System Information & Environment:
- Kernel Version: 7.1.8-zen1-3-zen x86_64 (drivers/misc/mei is identical to=
 upstream)
- Kernel Taint: 0 (Not tainted)
- CPU / Platform: 12th Gen Intel(R) Core(TM) i5-12500H (Alder Lake-P)
- MEI Controller: 00:16.0 Intel Alder Lake PCH HECI Controller (/dev/mei0)
- Graphics / DRM: Intel Iris Xe Graphics (i915 driver with mei_hdcp and mei=
_pxp components)
- Subsystems:     drivers/misc/mei, drivers/gpu/drm/i915

In mei_release(), closing the last file descriptor holding a virtual tag
invokes mei_cl_disconnect(). Inside __mei_cl_disconnect(), dev->device_lock
is dropped while awaiting the firmware disconnect ACK on cl->wait.

During this lock-drop window, a concurrent IOCTL_MEI_CONNECT_CLIENT_VTAG
call on the same UUID (e.g. MKHI) scans dev->file_list, matches the tearing=
-
down client 'pos' (in MEI_FILE_DISCONNECTING), repoints file->private_data
to pos, and adds its new vtag to pos->vtag_map.

When the disconnect ACK arrives, __mei_cl_disconnect() calls
mei_cl_set_disconnected(cl), setting cl->me_cl =3D NULL and
cl->state =3D MEI_FILE_DISCONNECTED. Because pos->vtag_map now contains the
second thread's tag, mei_release() skips unlinking/freeing cl. The second
thread then wakes up and attempts to reconnect via mei_ioctl_connect_client=
().

Additionally, shared clients lack tag based demuxing on cl->rd_pending in
drivers/misc/mei/interrupt.c:
  cb =3D list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list);

Incoming packets are matched to the head of the FIFO queue regardless of
vtag, causing -EPROTO errors, dropped packets, and out-of-order HBM command
sequences. This triggers continuous CSME hardware link resets:
  mei mei0: FW not ready: resetting: dev_state =3D 3
  mei mei0: unexpected reset: dev_state =3D ENABLED fw status =3D ...

During each reset, child client drivers (mei_hdcp, mei_pxp) unbind and rebi=
nd
with i915 DRM. With resets looping at hundreds of cycles per second (>9,800
events in 27s), mei_cldev_enable() repeatedly fails with -EFAULT / -ENODEV,
deadlocking i915 display worker mutexes in TASK_UNINTERRUPTIBLE and causing
an unrecoverable full system freeze.

Journalctl logs:
  mei mei0: FW not ready: resetting: dev_state =3D 3
  mei mei0: unexpected reset: dev_state =3D ENABLED fw status =3D 90000245 =
89110106 00000020 00004000 00021F03 446003CB
  mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: mei_cldev_ena=
ble Failed. -14
  mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: probe with dr=
iver mei_hdcp failed with error -14
  mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00=
:02.0 (ops i915_hdcp_ops [i915])
  mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:=
02.0 (ops i915_pxp_tee_component_ops [i915])
  mei mei0: FW not ready: resetting: dev_state =3D 3
  mei mei0: unexpected reset: dev_state =3D ENABLED fw status =3D 90000245 =
89110106 00000020 00004000 00021F03 446003CB

Proposed Fix:
- Prevent vtag reuse during teardown: in mei_ioctl_connect_vtag(),
   ignore existing clients on dev->file_list if they are in
   MEI_FILE_DISCONNECTING or MEI_FILE_DISCONNECTED states or undergoing
   teardown.
- Implement proper reference counting / lifecycle synchronization on
   shared struct mei_cl instances.
- In drivers/misc/mei/interrupt.c, demux cl->rd_pending by matching the
   incoming packet's vtag header to the corresponding callback rather
   than assuming FIFO order.
- Add rate-limiting / backoff to MEI client reprobing during hardware
   link resets to prevent cascading bus storms into DRM / i915.

A minimal standalone C reproducer (repro_mei_vtag.c) is attached below.

WARNING: Running this reproducer triggers an unrecoverable hard freeze
and display deadlock requiring a forced restart.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Standalone C Reproducer (repro_mei_vtag.c)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/*
 * repro_mei_vtag.c - Minimal Standalone Reproducer for MEI Vtag Reconnect =
Race
 * Compilation: gcc -Wall -Wextra -O2 -pthread repro_mei_vtag.c -o repro_me=
i_vtag
 * Execution: sudo ./repro_mei_vtag /dev/mei0
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#pragma pack(push, 1)
typedef struct {
=09uint8_t b[16];
} uuid_le;
struct mei_client {
=09uint32_t max_msg_length;
=09uint8_t protocol_version;
=09uint8_t reserved[3];
};
struct mei_connect_client_data_vtag {
=09union {
=09=09struct {
=09=09=09uuid_le in_client_uuid;
=09=09=09uint8_t vtag;
=09=09=09uint8_t reserved[3];
=09=09} connect;
=09=09struct mei_client out_client_properties;
=09};
};
#pragma pack(pop)
#ifndef IOCTL_MEI_CONNECT_CLIENT_VTAG
#define IOCTL_MEI_CONNECT_CLIENT_VTAG \
=09_IOWR('H', 0x04, struct mei_connect_client_data_vtag)
#endif
static const uuid_le MKHI_UUID =3D {.b =3D {0x15, 0x67, 0x6a, 0x8e, 0xbc, 0=
x9a,
=09=09=09=09=090x43, 0x40, 0x88, 0xef, 0x9e, 0x39,
=09=09=09=09=090xc6, 0xf6, 0x3e, 0x0f}};
static volatile sig_atomic_t g_running =3D 1;
static void sig_handler(int sig) { (void)sig; g_running =3D 0; }
static atomic_uint_fast64_t g_t1_ops =3D 0;
static atomic_uint_fast64_t g_t2_ops =3D 0;
static atomic_uint_fast64_t g_t3_ops =3D 0;
static int connect_vtag(const char *dev_path, uint8_t vtag) {
=09int fd =3D open(dev_path, O_RDWR | O_NONBLOCK);
=09if (fd < 0)
=09=09return -1;
=09struct mei_connect_client_data_vtag data;
=09memset(&data, 0, sizeof(data));
=09data.connect.in_client_uuid =3D MKHI_UUID;
=09data.connect.vtag =3D vtag;
=09if (ioctl(fd, IOCTL_MEI_CONNECT_CLIENT_VTAG, &data) < 0) {
=09=09close(fd);
=09=09return -1;
=09}
=09return fd;
}
static void *thread_vtag1(void *arg) {
=09const char *dev =3D (const char *)arg;
=09uint8_t cmd[4] =3D {0x07, 0x01, 0x00, 0x00};
=09while (g_running) {
=09=09int fd =3D connect_vtag(dev, 1);
=09=09if (fd >=3D 0) {
=09=09=09atomic_fetch_add(&g_t1_ops, 1);
=09=09=09write(fd, cmd, sizeof(cmd));
=09=09=09usleep(rand() % 40);
=09=09=09close(fd);
=09=09} else {
=09=09=09usleep(50);
=09=09}
=09}
=09return NULL;
}
static void *thread_vtag2(void *arg) {
=09const char *dev =3D (const char *)arg;
=09uint8_t cmd[4] =3D {0x07, 0x02, 0x00, 0x00};
=09while (g_running) {
=09=09int fd =3D connect_vtag(dev, 2);
=09=09if (fd >=3D 0) {
=09=09=09atomic_fetch_add(&g_t2_ops, 1);
=09=09=09write(fd, cmd, sizeof(cmd));
=09=09=09usleep(rand() % 60);
=09=09=09close(fd);
=09=09} else {
=09=09=09usleep(50);
=09=09}
=09}
=09return NULL;
}
static void *thread_vtag3(void *arg) {
=09const char *dev =3D (const char *)arg;
=09uint8_t cmd[4] =3D {0x07, 0x01, 0x00, 0x00};
=09uint8_t buf[128];
=09while (g_running) {
=09=09int fd =3D connect_vtag(dev, 3);
=09=09if (fd >=3D 0) {
=09=09=09struct pollfd pfd =3D {.fd =3D fd, .events =3D POLLIN};
=09=09=09for (int i =3D 0; i < 15 && g_running; i++) {
=09=09=09=09if (write(fd, cmd, sizeof(cmd)) > 0) {
=09=09=09=09=09atomic_fetch_add(&g_t3_ops, 1);
=09=09=09=09=09if (poll(&pfd, 1, 50) > 0)
=09=09=09=09=09=09read(fd, buf, sizeof(buf));
=09=09=09=09}
=09=09=09=09usleep(300);
=09=09=09}
=09=09=09close(fd);
=09=09} else {
=09=09=09usleep(500);
=09=09}
=09}
=09return NULL;
}
int main(int argc, char **argv) {
=09const char *dev =3D (argc > 1) ? argv[1] : "/dev/mei0";
=09signal(SIGINT, sig_handler);
=09signal(SIGTERM, sig_handler);
=09int test_fd =3D connect_vtag(dev, 1);
=09if (test_fd < 0) {
=09=09fprintf(stderr, "[-] Failed to connect with vtag on %s: %s\n", dev, s=
trerror(errno));
=09=09return 1;
=09}
=09close(test_fd);
=09pthread_t t1, t2, t3;
=09pthread_create(&t1, NULL, thread_vtag1, (void *)dev);
=09pthread_create(&t2, NULL, thread_vtag2, (void *)dev);
=09pthread_create(&t3, NULL, thread_vtag3, (void *)dev);
=09while (g_running) {
=09=09printf("\r[+] T1 (vtag=3D1 close): %lu | T2 (vtag=3D2 race): %lu | T3=
 (vtag=3D3 io): %lu",
=09=09       atomic_load(&g_t1_ops), atomic_load(&g_t2_ops), atomic_load(&g=
_t3_ops));
=09=09fflush(stdout);
=09=09usleep(250000);
=09}
=09pthread_join(t1, NULL);
=09pthread_join(t2, NULL);
=09pthread_join(t3, NULL);
=09return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Best regards,
Nirbhay Kumar
