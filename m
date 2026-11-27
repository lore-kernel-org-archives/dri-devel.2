Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397D606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=rr2yaJKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6013110E54B;
	Sat, 28 Nov 2026 09:41:02 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A24210E5A5;
 Fri, 27 Nov 2026 11:59:44 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id 2CB5420B9913;
 Fri, 27 Nov 2026 12:59:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 0ABDC20FB1AE;
 Fri, 27 Nov 2026 12:59:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 0ABDC20FB1AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795780783;
 bh=AnrZ4tj+JnyToCRG8bNK/82xlyPFVtmzzgAWkZzcblE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=rr2yaJKbgl2nz6w67CPjHNWIJxYYen7M7vEgfA9re7wfY+55F+qcja68CyCLdcZi+
 JuWMe8EtDtduhs18v1hXbKBZk2SNtq+OFsjuDM5VfQvZdxptI2JEMU3xqwaIC5FwCq
 pDC6ngzaUuABGQmvVTws7Se6SGeBZrjS0Sh7dwPdXdhNR/oaaOMZMksmzT85QaHGil
 xKDwTKRUlbH041/TcU9/MQRxGBxajh0Hni2+t0gU53re2/B4Eqk/gcHFaiCdMKGtRb
 FlN+W41/pQI2sd6M6sQjw08RS/N3x6peaQ6QBo1ymXI6aABGgPca/B1BMNLJ5TxTwV
 FaKKWPU+QhUWg==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id S6fcVkgtnLTT; Fri, 27 Nov 2026 12:59:42 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id B442620B9911;
 Fri, 27 Nov 2026 12:59:42 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2] drm/nouveau/fifo/gf100-: reset the faulting engine
 even if it switched channels
Date: Fri, 27 Nov 2026 12:59:30 +0100
Message-ID: <20261127115931.984281-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127113005.981725-1-frederic.mahe@cirad.fr>
References: <20261127113005.981725-1-frederic.mahe@cirad.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A related problem that this patch does not fix, found with the same
reproducer (nv-mmu-fault.c, below my signature; libdrm only, Fermi
only).

If a channel sends a graphics method while it has no graphics object,
and no other channel has one either, the GPU is lost: no MMU fault is
reported, so recovery never starts, the channel cannot be idled, and
every later client hangs in its teardown. A reboot is needed.

  nv-mmu-fault -e noctx-idle

sends one method to subchannel 0 after a SET_OBJECT of class 0x90b5
without the engine number, which routes it to GR. When another channel
does have a GR object ("-e noctx"), GR's context-switch unit faults
(READ at 0, HUB/CTXCTL) and recovery works with this patch.

This needs a working copy-engine channel: Ubuntu's 7.0 kernel lacks
a2b7b707d75e, so its TTM channel uses M2MF on GR, and GR always has an
object. With a2b7b707d75e (mainline), nothing keeps GR in use while no
client uses it.

Quadro 600 (GF108), Ubuntu 7.0.0-44 nouveau + a2b7b707d75e, with and
without this v2 (same result):

- While the channel is alive (40 s), the GR status (0x002640) reads
  80041002 (chid 2 =3D the channel, bit 31 set), and the FIFO raises no
  interrupt at all.
- When the process exits:

  nouveau 0000:01:00.0: nv-mmu-fault[16835]: failed to idle channel 2 [nv=
-mmu-fault[16835]]
  nouveau 0000:01:00.0: timeout
  WARNING: nvkm/engine/fifo/runl.c:251 at nvkm_runl_preempt_wait+0xf7/0x1=
10 [nouveau]
   nvkm_chan_preempt_locked+0x4a/0x70 [nouveau]
   nvkm_chan_cctx_bind+0xa7/0x170 [nouveau]
   ...
  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0d []
  (same warning, from nvkm_chan_remove)
  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0d []
  WARNING: nvkm/engine/fifo/nv50.c:228 at nv50_runl_wait+0xe8/0x100 [nouv=
eau]
  nouveau 0000:01:00.0: fifo: INTR 00000001: 0000000b

- A GL client started afterwards (piglit fbo-blit) times out in
  nv50_runl_wait, and its channel cannot be idled either.

On an NVS 315 (GF119), with our test tree that also has a working CE
channel, the FIFO does report it, as SCHED_ERROR 0a [CTXSW_TIMEOUT] every
4.3 s, with the GR status at 80041002. gf100_fifo_intr_sched_ctxsw()
then finds no engine to recover: gf100_engn_chsw() only treats the status
as a switch in progress if bit 28 (busy) is set, so the timeout repeats
forever.

Things I tried on the GF119, as experiments only:

- Treating bit 31 as "switch in progress" makes the handler trigger a
  recovery, but by then the status reads 01140002 and
  nvkm_runl_rc_engn() skips it ("not on channel").
- Remembering the channel at the timeout, recovering it and resetting
  GR led to a divide error in gf100_gr_init_zcull(), reached from
  gf100_gr_reset() -> gf100_gr_init() on a GR that was never
  initialised (tpc_total =3D=3D 0). nvkm_engine_reset() does not check
  whether the engine is in use.
- Doing only nvkm_mc_reset() for an engine that is not in use recovered
  11 of 11 rounds, and the GPU was fine afterwards. But bit 31 is also
  set during ordinary context switches, so channel teardown then polled
  for about a second each time.

I don't know what bit 31 of 0x002640 means (envytools has no entry for
it), so I have no patch to propose. Userspace should not be able to
take the GPU down this way. So far I have only hit it with the
reproducer.

Testing done with the help of Claude (AI assistant).

Fr=C3=A9d=C3=A9ric Mah=C3=A9

---8<--- nv-mmu-fault.c ---8<---
// SPDX-License-Identifier: MIT
/*
 * nv-mmu-fault: make a Fermi GPU take an MMU fault on demand, to test
 * nouveau's FIFO recovery.
 *
 * Opens the nouveau render node, creates a channel, and submits one push
 * buffer that makes an engine access an unmapped GPU virtual address
 * (0 by default).  The kernel is expected to report the fault, recover
 * and kill the channel; later submissions on it fail with -ENODEV.
 * Each round runs in a child process with a fresh channel; the child
 * exits without libdrm teardown (the kernel frees the channel when the
 * file is closed).
 *
 *   nv-mmu-fault [-e MODE] [-n rounds] [-a addr] [-V] [-w ms] [-r node]
 *
 * Modes (-e):
 *   gr     M2MF (class 0x9039, GR engine) inline write to addr.
 *   ce     copy engine 0 (class 0x90b5) copy between two unmapped ranges=
.
 *   both   ce copy, then gr write, on the same channel (on GF119 only th=
e
 *          first fault is ever reported: the channel is stopped at once)=
.
 *   noctx  a GR method on a channel that has no GR object, so no GR
 *          context (SET_OBJECT 0x90b5 without the engine number routes
 *          the subchannel to GR).  GR's context-switch unit then reads
 *          a null context: fault READ at 0, client HUB/CTXCTL.  The tool
 *          keeps a second channel with a GR object open meanwhile, so
 *          that GR is powered.
 *   noctx-idle  the same without that second channel: if nothing else
 *          uses GR (needs a working copy-engine channel, i.e. a kernel
 *          with a2b7b707d75e), no fault is raised: on GF119 the FIFO
 *          reports SCHED_ERROR CTXSW_TIMEOUT every 4.3 s, on GF108
 *          nothing at all until teardown; either way the channel can
 *          no longer be idled and the GPU is lost.
 * -V  control run: use a real VRAM buffer; nothing should fault and the
 *     channel should stay alive.
 *
 * Exit status: 0 if every round ended as expected (channel killed, or
 * alive with -V), 1 otherwise.
 *
 * Fermi only (GF1xx): the classes, method offsets and the SET_OBJECT
 * format (class | engine << 16) are Fermi's.
 *
 * Build: gcc -O2 -Wall -o nv-mmu-fault nv-mmu-fault.c \
 *            $(pkg-config --cflags --libs libdrm_nouveau)
 *
 * Written with help from Claude (Anthropic).
 */
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <linux/types.h>
#include <xf86drm.h>
#include <nouveau_drm.h>
#include <nouveau.h>
#include <nvif/class.h>
#include <nvif/cl0080.h>

#define SUBC_M2MF 2
#define SUBC_CE   4

#define M2MF_CLASS 0x9039	/* GR engine (0) */
#define CE_CLASS   0x90b5	/* copy engine 0: FIFO engine 4 */
#define CE_ENGINE  4

/* Fermi FIFO packet header: incrementing methods. */
static uint32_t
pkhdr(int subc, int mthd, unsigned size)
{
	return 0x20000000 | (size << 16) | (subc << 13) | (mthd >> 2);
}

/* Fermi FIFO packet header: non-incrementing methods. */
static uint32_t
pkhdr_ni(int subc, int mthd, unsigned size)
{
	return 0x60000000 | (size << 16) | (subc << 13) | (mthd >> 2);
}

#define OUT(v) (*push->cur++ =3D (v))

static const char *node =3D "/dev/dri/renderD128";
static uint64_t addr;
static int use_gr, use_ce, noctx, valid_buf, wait_ms =3D 5000;

static double
now_ms(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec * 1e3 + ts.tv_nsec / 1e6;
}

static void
usage(void)
{
	fprintf(stderr, "usage: nv-mmu-fault [-e gr|ce|both|noctx|noctx-idle] [-=
n rounds] "
		"[-a addr] [-V] [-w max-wait-ms] [-r /dev/dri/renderD128]\n");
	exit(2);
}

/* One round, in a child process.  Exit status: 0 channel killed,
 * 1 channel alive at the end of the wait, 2 setup error.
 */
static void
round_child(int r)
{
	struct nv_device_v0 devarg =3D { .device =3D ~0ULL };
	struct nvc0_fifo fifo =3D { };
	struct nouveau_object *chan, *obj;
	struct nouveau_client *client;
	struct nouveau_pushbuf *push;
	struct nouveau_device *dev;
	struct nouveau_drm *drm;
	double t0, t;
	int fd, ret;

	fd =3D open(node, O_RDWR | O_CLOEXEC);
	if (fd < 0) {
		perror(node);
		_exit(2);
	}
	if (nouveau_drm_new(fd, &drm) ||
	    nouveau_device_new(&drm->client, NV_DEVICE, &devarg,
			       sizeof(devarg), &dev)) {
		fprintf(stderr, "nouveau device open failed\n");
		_exit(2);
	}
	if (dev->chipset < 0xc0 || dev->chipset >=3D 0xe0) {
		fprintf(stderr, "chipset %02x: this tool is for Fermi (GF1xx) only\n",
			dev->chipset);
		_exit(2);
	}
	if (nouveau_object_new(&dev->object, 0, NOUVEAU_FIFO_CHANNEL_CLASS,
			       &fifo, sizeof(fifo), &chan) ||
	    nouveau_client_new(dev, &client) ||
	    nouveau_pushbuf_new(client, chan, 4, 32 * 1024, true, &push)) {
		fprintf(stderr, "round %d: channel setup failed\n", r);
		_exit(2);
	}
	if (use_gr && nouveau_object_new(chan, 0xbeef9039, M2MF_CLASS,
					 NULL, 0, &obj)) {
		fprintf(stderr, "M2MF class %04x not available\n", M2MF_CLASS);
		_exit(2);
	}
	if ((use_ce || noctx) && nouveau_object_new(chan, 0xbeef90b5, CE_CLASS,
						    NULL, 0, &obj)) {
		fprintf(stderr, "copy class %04x not available\n", CE_CLASS);
		_exit(2);
	}

	if (valid_buf) {
		/* Control run: target a real 4 MiB VRAM buffer instead. */
		struct nouveau_pushbuf_refn ref;
		struct nouveau_bo *bo;

		if (nouveau_bo_new(dev, NOUVEAU_BO_VRAM, 0x1000, 4 << 20,
				   NULL, &bo))
			_exit(2);
		ref.bo =3D bo;
		ref.flags =3D NOUVEAU_BO_VRAM | NOUVEAU_BO_RDWR;
		if (nouveau_pushbuf_refn(push, &ref, 1))
			_exit(2);
		addr =3D bo->offset;
	}

	if (nouveau_pushbuf_space(push, 64, 0, 0))
		_exit(2);
	if (use_gr) {
		OUT(pkhdr(SUBC_M2MF, 0x0000, 1));	/* SET_OBJECT */
		OUT(M2MF_CLASS);
	}
	if (use_ce) {
		OUT(pkhdr(SUBC_CE, 0x0000, 1));
		OUT(CE_CLASS | (CE_ENGINE << 16));
	}
	if (noctx) {
		/* No engine number: the subchannel goes to engine 0 (GR),
		 * for which this channel has no context.
		 */
		OUT(pkhdr(SUBC_CE, 0x0000, 1));
		OUT(CE_CLASS);
	}
	if (use_gr && use_ce) {
		/* Submit the bindings first, so that GR has switched to this
		 * channel before the two faulting operations arrive together.
		 */
		if (nouveau_pushbuf_kick(push, chan))
			_exit(2);
		usleep(20000);
		if (nouveau_pushbuf_space(push, 64, 0, 0))
			_exit(2);
	}
	if (use_ce) {
		/* 4 KiB linear copy from addr + 1 MiB to addr + 2 MiB.  Launched
		 * before the GR write: the copy engine runs on its own while
		 * the FIFO goes on to the GR methods, so in "both" mode the two
		 * engines can fault together.
		 */
		uint64_t src =3D addr + 0x100000, dst =3D addr + 0x200000;

		OUT(pkhdr(SUBC_CE, 0x030c, 8));	/* src, dst, pitches, size */
		OUT(src >> 32);
		OUT((uint32_t)src);
		OUT(dst >> 32);
		OUT((uint32_t)dst);
		OUT(4096);		/* pitch in */
		OUT(4096);		/* pitch out */
		OUT(4096);		/* line length */
		OUT(1);			/* line count */
		OUT(pkhdr(SUBC_CE, 0x0300, 1));	/* LAUNCH_DMA */
		OUT(0x00000110);	/* linear in/out */
	}
	if (use_gr) {
		/* Inline M2MF write of 16 dwords to addr. */
		OUT(pkhdr(SUBC_M2MF, 0x0238, 2));	/* OFFSET_OUT_HIGH */
		OUT(addr >> 32);
		OUT((uint32_t)addr);
		OUT(pkhdr(SUBC_M2MF, 0x031c, 2));	/* LINE_LENGTH_IN */
		OUT(16 * 4);
		OUT(1);					/* LINE_COUNT */
		OUT(pkhdr(SUBC_M2MF, 0x0300, 1));	/* EXEC */
		OUT(0x00100111);	/* push, linear in/out */
		OUT(pkhdr_ni(SUBC_M2MF, 0x0304, 16));	/* DATA */
		for (int i =3D 0; i < 16; i++)
			OUT(0xdead0000 | i);
	}

	t0 =3D now_ms();
	ret =3D nouveau_pushbuf_kick(push, chan);
	if (ret) {
		fprintf(stderr, "round %d: first kick failed: %d\n", r, ret);
		_exit(2);
	}

	/* Wait for the kernel to kill the channel.  The pushbuf ioctl checks
	 * chan->killed before anything else, so an empty submission (no
	 * pushes) is a side-effect-free probe.  (A real second kick would
	 * hit an assertion in libdrm once the kernel rejects it.)
	 */
	for (;;) {
		struct drm_nouveau_gem_pushbuf req =3D {
			.channel =3D ((struct nouveau_fifo *)chan->data)->channel,
		};

		usleep(2000);
		ret =3D drmCommandWriteRead(drm->fd, DRM_NOUVEAU_GEM_PUSHBUF,
					  &req, sizeof(req));
		t =3D now_ms() - t0;
		if (ret) {
			printf("round %d: channel killed after %.0f ms (probe: %d)\n",
			       r, t, ret);
			fflush(stdout);
			_exit(0);
		}
		if (t > wait_ms) {
			printf("round %d: channel still alive after %d ms\n",
			       r, wait_ms);
			fflush(stdout);
			_exit(1);
		}
	}
}

/* Keep GR powered for the whole run: nouveau only initialises an engine
 * while some channel has an object on it.  With GR up, a GR method on a
 * channel without GR context makes GR's context-switch unit read a null
 * context (MMU fault, HUB/CTXCTL); with GR down it only stalls the FIFO
 * (SCHED_ERROR CTXSW_TIMEOUT).
 */
static void
gr_holder(void)
{
	struct nv_device_v0 devarg =3D { .device =3D ~0ULL };
	struct nvc0_fifo fifo =3D { };
	struct nouveau_object *chan, *obj;
	struct nouveau_device *dev;
	struct nouveau_drm *drm;
	int fd =3D open(node, O_RDWR | O_CLOEXEC);

	if (fd < 0 || nouveau_drm_new(fd, &drm) ||
	    nouveau_device_new(&drm->client, NV_DEVICE, &devarg,
			       sizeof(devarg), &dev) ||
	    nouveau_object_new(&dev->object, 0, NOUVEAU_FIFO_CHANNEL_CLASS,
			       &fifo, sizeof(fifo), &chan) ||
	    nouveau_object_new(chan, 0xbeef9039, M2MF_CLASS, NULL, 0, &obj)) {
		fprintf(stderr, "GR holder channel setup failed\n");
		exit(2);
	}
}

int
main(int argc, char **argv)
{
	const char *eng =3D "gr";
	int rounds =3D 1, opt, r, killed =3D 0, alive =3D 0, errors =3D 0;

	while ((opt =3D getopt(argc, argv, "e:n:a:w:r:V")) !=3D -1) {
		switch (opt) {
		case 'e': eng =3D optarg; break;
		case 'n': rounds =3D atoi(optarg); break;
		case 'a': addr =3D strtoull(optarg, NULL, 0); break;
		case 'w': wait_ms =3D atoi(optarg); break;
		case 'r': node =3D optarg; break;
		case 'V': valid_buf =3D 1; break;
		default: usage();
		}
	}
	use_gr =3D !strcmp(eng, "gr") || !strcmp(eng, "both");
	use_ce =3D !strcmp(eng, "ce") || !strcmp(eng, "both");
	noctx =3D !strncmp(eng, "noctx", 5);
	if (!use_gr && !use_ce && !noctx)
		usage();

	if (noctx && strcmp(eng, "noctx-idle"))
		gr_holder();

	for (r =3D 1; r <=3D rounds; r++) {
		int status;
		pid_t pid =3D fork();

		if (pid < 0) {
			perror("fork");
			return 1;
		}
		if (pid =3D=3D 0)
			round_child(r);
		if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status)) {
			errors++;
			continue;
		}
		switch (WEXITSTATUS(status)) {
		case 0: killed++; break;
		case 1: alive++; break;
		default: errors++; break;
		}
		if (WEXITSTATUS(status) =3D=3D 2)
			break;		/* setup problem: no point going on */
	}

	printf("nv-mmu-fault: %d rounds, %d channels killed, %d alive, %d errors=
\n",
	       rounds, killed, alive, errors);
	if (errors)
		return 1;
	return valid_buf ? (killed !=3D 0) : (alive !=3D 0);
}
