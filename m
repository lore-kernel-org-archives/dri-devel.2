Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4ABC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E478F10E52D;
	Thu, 10 Sep 2026 14:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yDK83tuM";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD40510F4A4;
 Thu, 10 Sep 2026 14:20:52 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hgfwc0Wx4zMl30;
 Thu, 10 Sep 2026 16:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789050048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQ/dsCPkRG8hEn3IqMj2NKEg1v4mqBCakprJU0aCoeg=;
 b=yDK83tuM6+XDAbPc2le2pALPFq8W5BVcIimetsMdnPEdclRneYhqjS1y3oC/c/bBJgG67r
 XuT4wavxcHDLYyyYTI8MEeoJyO5028AwnvHRqSEi9MGn1DgceFBYmXVu4c99TzXE0cm4qp
 HpsIbRO10mhodXH31iX1ZCvP1xMlzJztp24mdMn1LB3pHc+qcvIHZQhzr5CKHiQcoPx61k
 0rXnHs40DTVU+PsbXoq4ZQQFBtii+nUTwaS4UP6aJpxFg0asIjPk275nuja5SGN+2GEyIG
 rUniRsinM6bllscsVwrP99j7CxOt/fyaxOojWpfFNiReYJYL+vXIgky6OwJweA==
Message-ID: <aee7e7be-b9c3-4d42-bc24-c29a94c0faaf@mailbox.org>
Date: Thu, 10 Sep 2026 16:20:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 2/3] arm64: dts: renesas: r8a779g0: Add GPU node
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Anh Nguyen <anh.nguyen.pv@renesas.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1789028076.git.geert+renesas@glider.be>
 <2399b2755ee8f825c22ab12242d718d64745b239.1789028076.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2399b2755ee8f825c22ab12242d718d64745b239.1789028076.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wqu6jecx34w95ps8nrex46srsx1mwh3e
X-MBO-RS-ID: b5df833567eded1f17f
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

On 9/10/26 10:19 AM, Geert Uytterhoeven wrote:
> Add a device node for the Imagination Technologies IMG AXM-8-256 GPU.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Fails to load firmware:
> 
>      powervr fd000000.gpu: Direct firmware load for powervr/rogue_30.3.408.101_v1.fw failed with error -2
>      powervr fd000000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_30.3.408.101_v1.fw (err=-2)
> 
> Firmware not available in upstream linux-firmware or
> https://gitlab.freedesktop.org/imagination/linux-firmware.
The GPU is the next generation (Volcanic), that is why there is no firmware.
