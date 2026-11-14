Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24D60A5BD2
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=SLmf0B96;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=20ooXzuP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1B110ED18;
	Sat, 14 Nov 2026 03:05:52 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF8C10ED18
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:05:41 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailflow.phl.internal (Postfix) with ESMTP id D5A881381A43
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:05:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 13 Nov 2026 22:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1794625540; x=1794632740; bh=UAxf1tA4Cr
 +7QlSDXCBd5HF4p7OMrXfL6oGEmLb4cQA=; b=SLmf0B96lGh0WKTDAucPkMFgEN
 Iq8h41jGljy4nBTL+FdQu0pDp/S9yXiE/lZVxmBMPPNrhZv8Cdxt7+nRwE+bg81R
 Vvi/4wjUBn+0L9oiMi3ley0y94fswPkXteiR74fxutN3NQCE1ZODqZTKEn2YXJg4
 a3IGa1zvp7qTXCbzXbd+AdZOqQgEsUCkKT6SbIMlXEF78wz8Q1aMHDQg7nbMOPhP
 7KYBbmcSMaTMzQDJbg+prwXsifYaK5ibE5bGj1dl7bdSW/1e1cVrL2NK0ggi/E25
 BpPHiN+NYZFKRB+A5BZ8pYCi2aDZYIuZn+CpQfKLSUux76gmTwE6UHdkfuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794625540; x=1794632740; bh=UAxf1tA4Cr+7QlSDXCBd5HF4p7OMrXfL6oG
 EmLb4cQA=; b=20ooXzuP5gZ71GZkBepmSqaoytsS2AYyGiBJQIcPHTKQDg28C/0
 RLxMd7iVCoc6ucoidvzcn5gTwZoqgFwV36kpSVCYSsu/YCzQLqYCH5LEr/vBqab5
 6Ny2hxzUhZ3nsksyftzSyqR79byQS7PI0YtVFnKQbAZPDuLa/ja9vt6W36w9+56s
 qMbeOCL7IhWQDJ2TF2ZEqqS+7tfYKrx77eZCU3Sn2S74Iil4cQayrsWfwvC6SxIj
 qhlyf5qbA0YfDBPGFo6Kms1g53kr9rNeWZ4yiIRPcwNuMlasALi5UFTFO5kUDRWD
 6Vw1NJ/KcVQJtQ7jIRMzmqie4o539FrMuEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625540; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:WcnYiYSUKFw5GD3z9q11T8AGZU+1oy9AmpF9Tc6Qo0kOw9v
 3/605x6cZIm9TwlfmlhryVlT9l7BnDfFIrFJmzOY1fUZVote5EvXj1H/Wn6bG3v6
 hd4qBP/lJWBjHWdyJ4cKKWe62cYbrZLagnfcrNkdVLbeWel0MX+emAHeRT4NRDRR
 dRv7ltbWKg/BxYvbzYIQq7ZlaZ+dunyzfZOk3AFX+6+gF10kyKkoe80BuQJbFbrn
 0A6MZlK0QqYkJT688/gNN+dTrGsY2quH4zvAXt1eHQxKavKQPXJPaWTd2WDoicd6
 /C10PLb87/CLX7vAFQ0hf0BiQdgfkajNopuC/mQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:SDtmj8snwKhq8a3m/AlQ2VN8lyhDTfavIW9m3/Hv9uQ=:Dxp8t0XS9CDQsuZULCGW4bCR/gfLgWevAxnrBCEXvoI=;
X-ME-Sender: <xms:A9D3angTc-jJQKx0ThFjBcTKyPvThemEnut9P74Wtw8oPCEbnZ_i2w>
 <xme:A9D3agebrEJfkntbm-8goOK0-XsiRYoNCujfEhjbpjdM46Ec1X4_VQp1nr5W5ThBb
 iPSvQy0cmnjfyUrd_jl_x3WKuzkSpPYNUSOGoftZ4QuXVmlHYc4p0s>
X-ME-Received: <xmr:A9D3auWWGH7B96NWRO8yJ7BP67qoYSODrwmYZ2-7EYDqW5XxwCwp2GvwUszfNxwfBL0UooGS>
X-ME-Proxy-Cause: dmFkZTEGsJpuk8b1nRIC2ZrNHABVA/y8lolim0B8NUFBfTO9HHBwOHtfr1x7E/bYF5Rt+N
 +fjHwgF+/FNTCnlkrazUp18/rPOl/rB3MJ9LPbCMpWMDKR7xfhSwxoxPOfrVjehsZ7rThv
 ObWwQdnjukeezJvsx5kDz3ycsHw9/RLsGLfuLEJD3Ydv7ya52aK6hdyT4N02jwdG3OB97/
 uAkfIG1lPXQjQwUOSldTArF9y9eMLQtbvdy8MTZ+DPxll8mMqe7lwyYcoBWgL6tVFYilbk
 MAUBYBkVsYjIUgH+DbbB8DukvKdVszTQM/MLV5Ry5ydTWvI5NAVGO8aCgn9iOHfgKVaAAm
 up1kE8+dA0pOwmdQtr63+CYXBeGBtrTBqHX9W6buBbK/luOWcT5tcmsOBVSzIHy7AT0XIS
 i1sZds4JFUx3zpbTCo5EdT8xqZ2oHuOdkmU2i8Up3xBOSTY3/POVhaxUfrF4KoC6Bs1mQp
 H+cq7dq/GHrUDAFxAhITR8mcFkDaXX1dftqHTA2oFN199H8xk5w/iR25U7SUnRT5oE7tUm
 pcynaSRKV1eOXdanBhPZF2mxX5XOeRgarTBfiAVIcBBTx2tZ8mQiLj5rAXFTT1mmKvw5iq
 8HNLrq5o4H7zFP6FqTUCvrgwTZ+dsaGxBqnTJxCa4NrbCTA9tfIZKfrzSvOg
X-ME-Proxy: <xmx:A9D3aqwZezan7IGAqtDx_WjYTbAkStq5wbiY39PeB8RObbHTrXRiNg>
 <xmx:A9D3alDb7fE8RwLpRRJtmCEAn5ewxmdvh-Xvu7VKAd_VIEumDIrAAg>
 <xmx:A9D3ag44kJmGA00JLhsf7K57Pk5D8wOY7VSwTMxvP8pnZ2RWIuvZIg>
 <xmx:A9D3aslmjpoQ6q5gljMj7oMNu3ZuU5jyze5kWObhF71nHilj1z5oBQ>
 <xmx:BND3aknGvxDzWrnVpXrprETPSNYjPF7oTQIq3S91xg89qomcRWza7CD9>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:05:31 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 00/12] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 14 Nov 2026 16:05:17 +1300
Message-ID: <cover.1794615324.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds RK3576 NPU (RKNN) support to the mainline DRM rocket
driver.

Based on: next-20261113

The pmdomain part of v16 9/16 is now a separate series on Ulf's next
(v16 10/16 is dropped). 12/12 needs its 2/3 to make the NPU domain take
its supply:
https://lore.kernel.org/all/cover.1794615323.git.gahing@gahingwoo.com/

Changes in v17:

- Dropped v16 7/16, 10/16 and 14/16 (the power-domain reset and the
  extra domain clocks), following Finley Xiao's (Rockchip) review.
- Following Heiko, the clock indices are now ROCKET_CLK_* constants
  (1/12 and 9/12).
- The pmdomain changes are now a separate series, linked above.

Testing:

Tested on a Radxa ROCK 4D running Armbian edge 7.3, with the v17
changes backported (this series and the pmdomain series):

- charsiu (https://github.com/gahingwoo/charsiu), an open source LLM
  runtime that drives the NPU through the rocket UAPI (/dev/accel)
  without Mesa or the vendor runtime, ran Qwen3-0.6B (Q4_0) 30 times
  after a warm reboot and 30 times after a cold power-on. Each run starts
  with the NPU power domain off. All 60 outputs are identical, with no
  job timeout, IOMMU error or SError.
- Job timeouts forced with a 1 ms timeout, three times in one boot:
  after each, the next run gives the same output as before, with no
  error.

The v15/v16 comparison of the reset order is in 4/12.

Logs: https://github.com/gahingwoo/linux-rk3576-npu/tree/main/board-logs

Known issue: in v16 I saw the IOMMU not recover after repeated resets
with a 2 ms job timeout ("MMU_DTE_ADDR is not functioning"). With v17,
after three rounds of forced timeouts in one boot, it recovered each
time; I have not looked into what changed.

Tool use:

An LLM helped me read code and technical material and write part of the
implementation. Some of the code in the series was first drafted by an
LLM, and the commit messages and cover letters of earlier versions were
mostly written by an LLM.

I reviewed the generated code and tested the changes on real hardware.
I also used an LLM to write test scripts and to compare register write
traces.

For v17 I wrote the cover letter, commit messages and code comments
myself in Chinese first and translated them into English with an LLM.

Tag changes:

- 1/12 changed in v17. Heiko, does your Reviewed-by still apply? If the
  change goes beyond what you reviewed, please take another look.
- 7/12 keeps Conor's Acked-by. The clock count changed from five to four
  in v16; Conor, please confirm it still applies.
- Tomeu, the GET_PARAM enum in 10/12 is unchanged (RK3588 = 1,
  RK3576 = 2). Is that fine?

Igor Paunovic (1):
  accel/rocket: request the core clocks by name

Jiaxing Hu (11):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
  accel/rocket: let the core suspend after a reset
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  accel/rocket: select the per-core clock and reset counts from match
    data
  accel/rocket: add RK3576 NPU (RKNN) support
  accel/rocket: add a GET_PARAM ioctl for the hardware version
  arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
  arm64: dts: rockchip: enable the NPU on rk3576-rock-4d

 .../bindings/iommu/rockchip,iommu.yaml        | 26 ++++++
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 70 +++++++++++++++-
 drivers/accel/rocket/rocket_core.c            | 14 +++-
 drivers/accel/rocket/rocket_core.h            | 20 ++++-
 drivers/accel/rocket/rocket_device.c          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 61 ++++++++++++--
 drivers/accel/rocket/rocket_drv.h             |  2 +
 drivers/accel/rocket/rocket_job.c             | 84 ++++++++++++++-----
 include/uapi/drm/rocket_accel.h               | 40 +++++++++
 11 files changed, 345 insertions(+), 37 deletions(-)


base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.43.0

