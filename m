Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4363C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2598410E053;
	Fri, 24 Jul 2026 08:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCi7ZHeF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F136510E051
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:59:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2EBB4093B;
 Fri, 24 Jul 2026 08:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93341F00A3A;
 Fri, 24 Jul 2026 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784883563;
 bh=dKusVM3kVcOjE7foTNZ9eX/mI/iaqI4t6R4iccmzPeQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=UCi7ZHeFNxXXCrLbCxs/iWD0b3gHpfgqHbcEQShM1fejtpNghYh2TB9HjV0wMM+Ed
 ZMK4mQ3ITFDkYOMkUWYcsJmva0eTUPyy+lYNmQo9LAPLnlYFPD5ptwTprf3TB8lXPA
 9JlpZSC3U3TmAOT+nRMp3BwpNHQGQzY/OCEDJ8UwfFW9HLE53Ovc8q0Imwaihl7U1v
 rpmjzxCHiTEMPD7MFvEbawC55AoVyN+ssZaPJJsJdRK7fbz+ehqjzqa4hCn4oZ6KpF
 BJq69eENhCMci1RM2VMw1x3+rN8maKWTMbgUSEdztzU9m7UnnAkohz9Av0lwYud8fX
 GxSJaqseCDjXQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-arm-msm@vger.kernel.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
 dri-devel@lists.freedesktop.org, arnd@arndb.de, 
 dmitry.baryshkov@oss.qualcomm.com
In-Reply-To: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v13 0/4] misc: fastrpc: Add polling mode support
Message-Id: <178488356170.437795.14308617091553113236.b4-ty@kernel.org>
Date: Fri, 24 Jul 2026 09:59:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Mon, 13 Jul 2026 10:52:32 +0530, Ekansh Gupta wrote:
> This patch series adds polling mode feature that have been missing in
> upstream FastRPC driver.
> 
> - Add changes to move fdlist to ctx structure to avoid code duplicacy.
> - Update context mask to support polling mode.
> - Add changes to support polling feature.
> 
> [...]

Applied, thanks!

[1/4] misc: fastrpc: Move fdlist to invoke context structure
      commit: a73359512125b686b010c25530f8768cb0fd4632
[2/4] misc: fastrpc: Replace hardcoded ctxid mask with GENMASK
      commit: 10555ba6126ede14a98af991c6613151a2cafa5a
[3/4] misc: fastrpc: Expand context ID mask for DSP polling mode support
      commit: c49f7643576630fb602adf927eb17399b19da6b0
[4/4] misc: fastrpc: Add polling mode support for fastRPC driver
      commit: fefb8b2aa4cc5273e7564903941ae49540e0dfc5

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

