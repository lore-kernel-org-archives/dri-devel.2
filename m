Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85AC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963B710EFC7;
	Wed, 12 Aug 2026 13:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="li+KILZ2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B9E10EFC7
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:06:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C79EF60A92;
 Wed, 12 Aug 2026 13:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B722F1F00A3A;
 Wed, 12 Aug 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786539975;
 bh=ieMi1YOLEm68OiqSoUaPWHyIcFAubRgu4F1dHKVmdUM=;
 h=From:To:In-Reply-To:References:Subject:Date;
 b=li+KILZ2lHzTbCIzmaYicjsbCyLp13CjM7vpqNnAXFubaPbRcxtfktNhAHoBrQlOk
 nZRsn1rj0dHj3vU54oRc0UNZz9eVcZq2ET7XBbilBf+RsGk5w+mp1muCVwszqm4vV/
 N6AKjXyQqEU/hUs7zwkyXi7KGqUJClQMmRId7YjpTpvyjVYuYwzMxhjk31MV7xlWIq
 hZI+kVEwS9FqkQWD/RbwHfPhVzv40Vz0I1BF2IztPU1LtvYDc9QaLwP0o3tgRjoYzL
 McbFxX0ig+ifmnUhuAVbVPPH4GtvZsmvpe3F1OFSx0InGBx7IZ+pryhS8J7HH8fTLm
 GWUulgvf37vbA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pan Chuang <panchuang@vivo.com>
In-Reply-To: <20260722065709.346072-1-panchuang@vivo.com>
References: <20260722065709.346072-1-panchuang@vivo.com>
Subject: Re: (subset) [PATCH] backlight: qcom-wled: Remove redundant dev_err()
Message-Id: <178653997347.1416472.14861848371545325134.b4-ty@b4>
Date: Wed, 12 Aug 2026 14:06:13 +0100
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

On Wed, 22 Jul 2026 14:57:08 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.

Applied, thanks!

[1/1] backlight: qcom-wled: Remove redundant dev_err()
      commit: 0bf739c3cd22b17af7c31c3d8d0777e1e6574429

--
Lee Jones [李琼斯]

