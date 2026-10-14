Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F912CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED74010FD51;
	Wed, 14 Oct 2026 12:31:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2915A10FD45
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 908EE40601;
 Wed, 14 Oct 2026 12:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C41F00893;
 Wed, 14 Oct 2026 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791981061;
 bh=WmMdzxPlejQaqZNa3UTkzpuCVe+6o2oOl7wZ2XqTuo4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=blfQHchGOVRFFMFi9S0YYv9imMp5lzosnABYBn1sqEGK120DSF7lPqIS0uJVXR9pp
 Q/LdcvPMrqGMPt4AlprwLZ5KMCClE2Q/08BMbMM05PuzGTTVN4J/nB5iBFSET8i1pP
 b+7xTMNuYJMV7zGIkcTSjOT8z4lIOF8psQCjjB1f2OWbgPEW1dAoR1ln2yjfui3veB
 mimECd9i9fZb+N4ls7BN1iaqTZBUhJIgmMa0B5INvaTZ8xZchOu5TdAoevFeqALSvT
 mCvRcpP5GbhskOlHJ9ZkFfsqplq7C/9Q/ojxfWLiQ6gAEd6koP874402sMWAB+JakL
 xJfDQQlFuEFNQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-Id: <179198105841.810389.574989948392370179.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:30:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> The qcom-wled OVP interrupt is enabled at probe whenever the module is
> already on, but the driver still believes the backlight is off, so the
> first brightness update re-enables the interrupt and trips "Unbalanced
> enable for IRQ". sdm845-mainline has carried a workaround for years and
> Joel posted a flag-based version last October [1], which Konrad and
> Daniel asked to be replaced by something that does not track the IRQ
> state by hand.
> 
> [...]

Applied, thanks!

[1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      commit: 1dbd46d4b2fb416a8202b1a8e4ef9d0cadbe075f
[2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
      commit: 22672f81f0724cbabb272fd0228fa424d4306082
[3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      commit: 5eda6b51461932f9fd835ef9e4574650c69c4fe8
[4/4] backlight: qcom-wled: Read back the programmed brightness at probe
      commit: eacfbe6f9716d00536edc229a58895405e73c2e4

--
Lee Jones [李琼斯]

