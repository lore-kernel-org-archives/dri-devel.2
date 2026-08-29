Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAB1C61DB9
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 01:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B88410E0A0;
	Sat, 29 Aug 2026 01:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPPzFT1N";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF91510F08C
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 01:05:30 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso2170215a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787965529; x=1788570329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zA5kSADrAaVAB+/2hR/f9WTYy/x0O4VhWpKvkd8WRIQ=;
 b=iPPzFT1N1CmeiMlrFPg9pZB0PvpiIwJbgrsZ8nXQkdfZiCrDrbx6M+5FNxdVkR2p2E
 hR/QrW1PuktSDgolhzUig07XgDnnYvA71Q0LnCj3iRsTb8pbral/pMnBmgC2jOUk8yMC
 YRoEFFMJ/UR6v9IKwDAtPvpR7Bit3LtaF9MUWc+kyt+DogNpAdsu7Ni9qjPFgYH4yV1Z
 DQBPIfj+iH1T4ap/wTceG9isXz65UuTrX/+Rgu362BmPF285lg0KnhvtEUp1EOB0o3ge
 0yPhIlq+QX0fhw3W5cS3fpX8PVVWsqhoyruX9UtdVsPH6WwS+KkvErMTuPiPUqUoOKTx
 Mbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787965529; x=1788570329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zA5kSADrAaVAB+/2hR/f9WTYy/x0O4VhWpKvkd8WRIQ=;
 b=nqJ2xi8PU8rxUeSvYCOaA63OiXXYfVOpdysMTOfRHiW/Whv4ZgHlc/4iLUOVg15TnG
 j/C3w8rmZZkWEMTnj7Kk8p6Yd2Q2UPbEiTCN/avLU/7soloXbCxttlH8xsd3GjUubVUT
 HMAm49sNWDB8/ptPqzE5Gkn2iA8sIThgXEpOp+RDwbmHAHfFXBr3wy3Gakq/O/Gf7nxA
 ciPTpT3RqYZkTNUftoKUAhhuWQuRSuh0BtclxjFOtEeNG7sEKHG/6PHhtOXhXl8kBncr
 aJIsYv2nEVYMTlcn9M46Jojzg8JHwecx2q/Vgb8Z7Ksd1yUJhv76qfVuZsOjU5h2oCgb
 wUQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrO5MX1meN9liSw1Zkr7BGKWp8rrBskRmfe9kuV5hBnNGU4B5Dhs3mJsCXQtK1xDUxPeDfrUTweU4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhsEyNh0LbpXi9tbuIvneMY87nmpvYrX8VeNnc8SK0FseywaWB
 pMElXRtbE55oSxKdFSXD/t1a9Dv6kYyDM3pcs0KrFC0lho/xY/V7eRax
X-Gm-Gg: AR+sD12S8VL3GP+AOLVX8xaugQPExDFNnwkTrlkSZVgkNrjVQj6aAdFsLBLd5y2qbrn
 2OnOXp0RFFGl6KwL1RWsjxvsW2voLCi0uA/sfr1QJgb1La1tWvLTylqvfsigUvZC8fgg0ZPajvt
 T7OfQMxxcJT0brBVLez9iUGr/4lZFGUNnnZ6VwVJav4x5AQjIvF8nqiSDeCTZLW+0LDhDM8pYi8
 j5QzMVWB2I2dhzFIgwo94FgadkfqUfrc93umkrFZ+vQSLcGzfeUFDt+LDF1XxvBEiSyPHp69BWj
 BmS2qo/I/AG35znBhNDABfnBOGNDKrp63nsM6gcbEpMgFrLpX+326plxTiet3XFQJN45fLLMRiN
 uyP3wAHqd4N8Yi6y4OakRa2YHeTBOPZXWbEKFniUROpRCfUvfpxyX2EHu66mt+ZGOSEY9WyP0JC
 MDt0C2xtIAi5cM6PpBCfoROKbGrFk4nKe1FFiD21moi4Ha8ilZjM0dA66/wT5MCNHdRCuz3yu8h
 1nmoTITzWEUk3HnDW9zcfRfNhWNi2HQSfL8vQl/boTGfVPBbNMf7GgAlDZ+
X-Received: by 2002:a17:907:94c1:b0:c25:6230:dfcd with SMTP id
 a640c23a62f3a-c256230e4d2mr524252866b.15.1787965528961; 
 Fri, 28 Aug 2026 18:05:28 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b28ebsm141649666b.29.2026.08.28.18.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:05:28 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption on
 DCN32 at 120 Hz since a637a140ab86
Date: Sat, 29 Aug 2026 06:05:25 +0500
Message-ID: <20260829010525.29935-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since the 7.3 merge window my desktop shows a band of pixel noise flashing
across the screen at random on a 3840x2160@120 display driven by an
RX 7900 XTX (Navi 31, DCN32).  Each occurrence lasts exactly one frame -
8.3 ms - which is why it reads as a flicker rather than as corruption.  It
is frequent enough to be painful to look at during ordinary work.

The band is not new.  It existed before, rarely enough to ignore, and back
then a modeset (switching to 60 Hz and back) cleared it for a while.  What
changed this merge window is that it became roughly two orders of magnitude
more frequent, and the modeset workaround stopped helping.

What I would like is help finding the underlying bug.  I am not asking for a
revert: reverting the commit below does not fix the artefact, it only takes
the rate back down to what it was before.  I could not work out how the
commit leads to the symptom, so most of this mail is measurements and a list
of mechanisms I was able to rule out.

A photo of the screen, taken with a phone because the artefact never appears
in a screenshot:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714


Measuring it
------------

The artefact is invisible to screen capture but visible to the CRTC CRC
engine.  A frame in which it occurs has a CRC triple that differs from its
neighbours while the neighbours are byte-identical to each other: displayed
content did not change, but one scanned-out frame did.  A torn readback
cannot produce that, because inside such a window the adjacent frames are
identical and there is nothing to mix.

The colour band moves all three CRC registers.  Single-frame content
flicker in grey areas moves only CRC1 (Y), because on this YCbCr link the
chroma of an achromatic region is unchanged.  That gives a built-in control:
the CRC1-only population is content, not corruption, and its rate should not
depend on the kernel.

All figures below are per *eligible* frame - frames where the quiet window
existed - so runs against differently busy screens stay comparable.


The regression
--------------

I bisected the change in frequency to

  commit a637a140ab86 ("drm/amd/display: Allocate DCN32/1 dmub memory to GTT")

Each bisect step was judged by eye over a kernel build's worth of ordinary
desktop use at 120 Hz.  That is a weak criterion for a probabilistic bug, so
I re-tested the endpoints with the CRC detector instead.  Both runs were
ordinary desktop work, same machine, same display, no modeset before either
run:

                              a637a140ab86      a637a140ab86
                                reverted           present
  observation                    8.06 h            6.43 h
  eligible frames              1,621,663         1,382,934
  events, all three CRCs              12               924
    per 1000 eligible               0.0074            0.6681
  events, CRC1 only (control)         30                32
    per 1000 eligible               0.0185            0.0231

The artefact signature is 90x more frequent.  The content-flicker control is
flat at 1.25x, so the detector, the screen activity and the sensitivity were
comparable across the two runs.

The composition changes too: with the commit reverted, 24% of detected
events are all-three; with it present, 94% are.


Refresh rate
------------

  4K120, YCbCr 4:2:0, 8 bpc, TMDS 594 MHz   artefact present
  4K100, YCbCr 4:2:0, 8 bpc, TMDS 495 MHz   artefact present
  4K60,  YCbCr 4:4:4, 8 bpc, TMDS 594 MHz   0 events in 70,691 eligible
  4K60,  YCbCr 4:2:0, 12 bpc (forced)       0 events in 1,290,588 eligible

The last row was measured with force_yuv_pixel_format=4 to separate refresh
rate from chroma subsampling, since the two change together on this display.
At 60 Hz with the same 4:2:0 encoding that shows the artefact at 120 Hz,
1.29 million eligible frames produced nothing.  Link bandwidth is not the
variable either: 594 MHz appears in a configuration that shows the artefact
and in one that does not.

So the dependency is on frame rate.


What I could rule out
---------------------

Twenty DTN snapshots taken within seconds of confirmed events, on the kernel
with the commit reverted:

  - HUBP underflow and OTG underflow read 0 in all twenty.
  - dcfclk, dispclk, dppclk and fclk are identical in all twenty; no clock
    transition happens near an event.
  - vmax = vmin = 2249 with both select bits set, in all twenty: DRR is armed
    but pinned to nominal, so no vblank stretching is available.
  - The watermark sets, including dram_clk_change, are identical throughout.

Caveat: the snapshots are taken seconds after the event, so a momentary
transition would be missed.  But vmax = vmin and the identical watermark
sets are configuration, not instantaneous state.

Reading the commit, the buffer is pinned by amdgpu_bo_create_kernel(), so
TTM eviction is not a factor either.  What the commit moves out of VRAM is
every DMUB FB window at once - instruction constants, stack, BSS data,
VBIOS, mailbox, trace buffer, firmware state, scratch, IB, shared state,
LSDMA buffer and cursor offload.  I do not know how that leads to a single
corrupted scanout frame; that is the part I am hoping someone from DC can
see.

Two details from the diff that I am not able to judge myself.

AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is still set unconditionally in
amdgpu_bo_create_reserved(), and with the domain now GTT-only it no longer
does anything.

The commit immediately before this one in the same file is 5b69770e945c
("drm/amd/display: Generalize DMUB memory flushes from host"), which adds a
dmub_srv context parameter to the flush helper; the Linux implementation
still ignores it and remains the generic read-back loop. That helper is
called on scratch_mem_fb, on ib_mem_gart and on inst_fb during backdoor
load. Before a637a140ab86 the remaining windows sat in VRAM; now all twelve
are in system memory. Is that flush coverage still sufficient for the
windows that moved? I am asking, not claiming - I do not know the coherency
model for these buffers well enough to say.

The commit's own comment says the restriction to DCN32/321 is temporary and
that it will be made general to other dGPUs later, which is why I would
rather this were understood before it spreads.


Configuration
-------------

  GPU        : AMD Radeon RX 7900 XTX (Navi 31, DCN32), 1002:744c rev c8
  iGPU       : Raphael 1002:164e, bound to amdgpu, drives no display
  Board      : ASUS ROG STRIX B650E-I GAMING WIFI, BIOS 3854 04/03/2026
  CPU        : AMD Ryzen 9 7950X
  Display    : LG OLED42C3 (42" OLED TV), HDMI, 3840x2160@120
  Timing     : 3840 4016 4104 4400  2160 2168 2178 2250, 1188000 kHz
  Encoding   : YCbCr 4:2:0 8 bpc at 120/100 Hz, YCbCr 4:4:4 8 bpc at 60 Hz
  FreeSync   : enabled, range 40-120, reported FIXED by the display
  DSC        : off
  Kernel     : 7.2.0-66498c75b4f8-with-fixes-v1-m62-quirk+
  Userspace  : Fedora Rawhide, GNOME on Wayland

The kernel is tainted W: opening the CRTC CRC debugfs file triggers a
WARN in dc_helper.c on DCN32.  That is a separate bug in the same merge
window, with a patch already posted:

  https://lore.kernel.org/all/20260829004608.25252-1-mikhail.v.gavrilov@gmail.com/

It does not affect CRC0, which is what the measurements above use.

Both the capture tool and the raw logs are available if they would help.

Thanks,
Mikhail Gavrilov

#regzbot introduced: a637a140ab86
#regzbot title: drm/amd/display: single-frame scanout corruption on DCN32 at 120 Hz
#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714
