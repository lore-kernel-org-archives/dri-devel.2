Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A22C5DF9B
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4765D10E367;
	Sun, 23 Aug 2026 09:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ni98Z3hU";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254A410E3C6
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:53:16 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d032846c95so22379775ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787388795; x=1787993595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bR7LrEDWYTPsnuOnqVtcGLotVp78B6n1a5iwn0JbEJk=;
 b=Ni98Z3hUL2S7vC+MoNYCwvw4fc9g5QNP/dpsMgwZ01nYscudyfX7itnx4fLl7a8wwJ
 wEkMztBxLiHhqW0bkW1zLsHEfVWZGjKP/+U3jiffyeOyy/bR+FuEE8W67Oj2RXwHq3cM
 +qgKi4uI3/opBXbApcAcPxjb7hKGte02JjcE57ZZPQwC4toKhYbo/qwH8pWW2P1GvcUf
 BGgdJR7bcBBPMiE8o3lxARp99lJGtGcbhHG1U4pYVRgg2DpOaRweJRvmr1reVrVhy5XS
 qiC7wQL1icq7gknWB7VO989grHKTCfX+yRZKYE7T/YcFpdw3PmvEd+WRQmaeH46muGrE
 rJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388795; x=1787993595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bR7LrEDWYTPsnuOnqVtcGLotVp78B6n1a5iwn0JbEJk=;
 b=o8xPJ0Iq6ePVKXrpygCFUMinvjwvxpTt/nMBwAfLVMw2x+iEhr9y3q5xFwg3UwlOtN
 uYzgSjAYwBuq+PfU4T+6T5KUWgGezxXeZl2iQ2f/dn3jv3AZdXQtYXeAkQQwNDATanED
 x5C0Nwp9lSDR8q3ep3YpbbDkiWdivLC+BbdJe8mhn3SB8NK5f4UFRiZ2dsWf2cSQ5elR
 pVYVfGBg9DX5mFfnINk4jpB6PmeUrtMtQ+9tCc2XXS376/yC9l3U/stc/6t4DSOebVfa
 v5XzTbqYWbLDjaOhdLE2ugpwSKITC6ry+ibNosP8BJcioBoGCSHi76OhuFmHIr9SjedR
 YKIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpngcXLkU0UkJLazUNH0okM8RcbCfI6LrEIvBVjNV6YCWwv9IN7H1y3A21tlLBLnmczPUVMnIw01xs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQmZx64m0naSXznAc7WtAUfs6U1ystw24thnkMtdnrlD/DITsI
 OtNEq7iNPo0doxOmhgfLntpOSGZRvn1JSMBL7QuRajMy8vsFdev18u24
X-Gm-Gg: AR+sD13si3EE5g5i60ONUlhSDWHB64Nu6HtAcgOzOyGiprGGEONINXvHtU4KkKsNdEy
 2ydZuTeAcwRP5PFWsHqp05tQKlKUt+FH0ZILn+VWabYvEPr00cw36TW8IxjGAz/59Rh2/hZtBqO
 kBPRpqw7aZMwu4WBE78AmXuL47CRDpIMivmY/XqRmn6Z3Kvk9Wf19uaw1vK9HQHzJoHTfpvuFFh
 RxEpqTxs6xMerEzKaYJvEoZ51Y3OBJ0BIhR/cRwWVNFjsKIpFDUA4sATZKbyJeeJ3yESgHHAhCR
 uUQrgzbJ7G6lQiB5Hb0nTbaXQuNsPI5J/+R2hscs1vX9SYyuHewwkARp/Ql9x8ruX1NFulLJq0d
 UilL6kcAnM0AFfGemIUUMvspiMhUekrrmmG85aIeCI2DDn6SlE7XMMZmRwBt/lC6mtbhSsWvrs7
 3KwS1r7kWtAeNaw3wJ3Q1ZfDQdZ2B8TFzl45i6fZ9gyNTm1Cuzbz/F9+FVrCJvrO8BDqGtRdtZm
 lDxQg2PdMC6N88=
X-Received: by 2002:a17:902:ec86:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d64ae3ac9emr225062945ad.2.1787388795383; 
 Sat, 22 Aug 2026 01:53:15 -0700 (PDT)
Received: from mcp-node.. ([240d:f:fe4:c00:e9d:92ff:fe83:dbda])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d67676170fsm2982575ad.6.2026.08.22.01.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:53:14 -0700 (PDT)
From: Yuta Higuchi <avablaba@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] drm/xe/hwmon: wake render domain for BMG package
 temperature
Date: Sat, 22 Aug 2026 17:52:02 +0900
Message-ID: <cover.1787385860.git.avablaba@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

Hello,

This RFC addresses a reproducible stale package-temperature value on one In=
tel
Arc Pro B70 (8086:e223). During GPU activity, temp2_input changes continuou=
sly.
After the workload exits, it changes for only a short lifecycle burst and t=
hen
remains fixed for more than 200 seconds during idle cooldown. Other telemet=
ry,
including VRAM, mctrl, PCIe, fan, energy, and runtime state, continues to m=
ove.
An independent PID reading the same sysfs node sees the same result.

The symptom reproduces after cold boot, without OpenVINO, with a standard
clpeak workload, and on Linux 6.17, 7.0, 7.1.5, and 7.2-rc7 using the same
official BMG firmware. Holding runtime PM active alone did not restore idle
updates, and a controlled Xe reprobe did not restore continuous updates.

The tested firmware is byte-identical after decompression to official
linux-firmware main:

- DMC 2.6, content SHA-256
  76e3ec6ea3a53ce727e43b84f5ea14c55400a2d118dac356d4e12a3cfac06b4d;
- GuC 70.72.1, content SHA-256
  de81c75f46a127c33cd59f604d800e9ffc7ed3495967ba0d8767cd6985ab398b;
- HuC 8.2.10, content SHA-256
  747452aa8c4ed7760c68a80f3d913eafde9304d6f4db481e3f2aebb0a818bf15.

Source path and causal isolation
--------------------------------

For BMG, temp2_input reaches BMG_PACKAGE_TEMPERATURE (0x138434) through
xe_mmio_read32(). On the tested B70:

- stock forcewake_all kept package temperature updating;
- main-GT XE_FW_RENDER alone was sufficient in 3/3 independent persistent
  holder rounds;
- releasing the RENDER holder was followed immediately by renewed staleness=
 in
  3/3 rounds;
- main-GT XE_FW_GT alone was negative in the single persistent-holder round
  tested;
- a transient RENDER acquisition produced the first fresh publication after
  1.17 to 2.172 ms; and
- after a 20 ms RENDER hold with no sysfs reads, the first package-temperat=
ure
  read was already fresh.

These observations support a wake/publication dependency rather than a
collector or sysfs-reader problem. They do not establish that register
0x138434 architecturally belongs to XE_FW_RENDER, nor whether PCODE, GuC, or
other firmware produces a shadow value.

Proposed RFC behavior
---------------------

For the BMG package-temperature channel only, acquire the main GT
XE_FW_RENDER domain, wait 3.0 to 3.5 ms, read the mapped package-temperature
register, and release the reference automatically. Forcewake acquisition
failure is returned as -ETIMEDOUT, following existing Xe forcewake-ACK time=
out
precedent.

The 3.0 to 3.5 ms settling interval is empirical. The maximum fresh transit=
ion
latency observed in the transient tests was 2.172 ms. FORCEWAKE_ACK_RENDER =
is a
wake-domain acknowledgement; it has not been shown to be a temperature
producer-ready acknowledgement. The fixed delay is not presented as an
architectural contract.

Scope and known limitations
---------------------------

Runtime validation was performed on one Arc Pro B70 (8086:e223). The RFC is
scoped to Battlemage because the affected package-temperature path is
BMG-specific; guidance on applicability to other BMG devices and steppings =
is
welcome.

XE_FW_RENDER was single-domain sufficient among the directly compared state=
s.
XE_FW_GT alone was tested once and was negative. Media, GSC, and other
individual forcewake domains were not tested after the RENDER-only positive=
 was
established. This RFC does not claim that RENDER is the unique minimum among
every possible domain combination.

Validation
----------

Extensive runtime validation was performed with the equivalent diagnostic
implementation on Ubuntu 7.0:

- three independent 180-second cooldown rounds;
- 1, 5, 10, and 30 second read cadences;
- four concurrent readers (240/240 successful reads);
- 30 minutes of continuous operation;
- OpenVINO ruri-v3 and bge-m3 requests;
- suspend/resume; and
- controlled Xe unbind/rebind.

No GPU hang, reset, fault, or wedge occurred. Persistent RENDER forcewake h=
ad a
large power cost, whereas read-scoped references allowed GT idle residency =
to
advance. The displayed cur_freq remained 2800 MHz while act_freq was zero a=
nd
GT C6/idle residency progressed, so cur_freq was classified as telemetry st=
ate
rather than evidence of a physically busy GT.

The rebased current-tree candidate was additionally smoke-tested directly as
7.2.0-b70rfc2+, based on drm-tip 75140c4ee9ad. With the standard clpeak
workload, both a main reader and an independent PID observed package
temperature continue from 46 C down to 44 C during a 180-second cooldown.
act_freq was zero, GT entered C6, and idle residency advanced by 178.25
seconds. A separate bounded candidate-kernel test returned HTTP 200 for
OpenVINO ruri-v3 and bge-m3. No hang, reset, fault, wedge, or taint occurre=
d.
This direct smoke does not include the 30-minute, suspend/resume, or reprobe
tests listed above; those were run only with the equivalent Ubuntu 7.0
diagnostic implementation.

On stock kernels, a separate operational workaround submits one warmed Intel
ICD work-item / one Xe job every 30 seconds and reads temp2_input 50 ms lat=
er.
That workaround refreshes snapshots but is not the proposed kernel behavior.

Related issues
--------------

Primary: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7805
Secondary: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4560

Questions for maintainers
-------------------------

1. Is 0x138434 a live sensor register, or a shadow value published by PCODE,
   GuC, or other firmware?
2. Is there a documented producer-ready indication after XE_FW_RENDER is
   acquired?
3. If not, what is the official minimum delay or refresh sequence for this
   register?

If an existing mechanism is available to trigger or wait for
package-temperature publication, I would prefer that over the empirical
settling delay used by this RFC.

Coding-assistant disclosure
---------------------------

AI coding assistants were used during this investigation and RFC preparatio=
n:
Claude Code for the initial investigation and independent review of the pat=
ch
against the current tree, OpenAI Codex for implementation, evidence collect=
ion
and test orchestration, and ChatGPT GPT-5.6 Sol Pro for investigation plann=
ing,
submission workflow design and review. The human submitter reviewed the
resulting code and evidence and takes responsibility for the submission.

Thanks,
Yuta Higuchi

Yuta Higuchi (1):
  drm/xe/hwmon: wake render domain for BMG package temperature

 drivers/gpu/drm/xe/xe_hwmon.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)


base-commit: 75140c4ee9ad250b2524ff5bfffd7f9fe4bb6012
--=20
2.43.0

