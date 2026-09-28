Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74509C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F6110E7B2;
	Mon, 28 Sep 2026 07:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ScIplp95";
	dkim-atps=neutral
Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com
 [74.125.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E11510E7B2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:04:07 +0000 (UTC)
Received: by mail-lr2-f34.google.com with SMTP id
 38308e7fff4ca-3a652e2149aso20363351fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 00:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790579045; cv=none;
 d=google.com; s=arc-20260327;
 b=JQygJvRJyUALZPcE8yjY++hRt1Ci4g/FO93rmvnazp7DOsbhQ/i1dlU3qS2Y/fs7Mk
 bWz7Zm07Q0JHIxPJZ6nWIY+6Yt36NnLER7nVrGieSKeud0iAj8iA5p+tvPnomG3hTBiH
 ltK6TbsRMV9ngRcDmoqt3Rz0iYKLOlgHk7INQ+FLNDhtk03CCwdL1YNI2rGIF036UDvp
 Fc4YuvexRPzajS7iEnP3s5n1hcJy5qMg6HZksu2bFtaGzxkKIGjKcfEAKH9yILLOFWgz
 OuZBn8ylmgETaSyn5dwsXQ82FEDpsZpRkbdhIEpu/OIHZo5P1WEl/l1KYzuuztkSQbrY
 cZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QcQk7d4pb6MSovoeWWdDkkdL6cfWPIu5znyjI13+lN4=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=BteZ5JfJ7v+pFK/HY3qc+H/AC00K0BPvbEnNXS/JzWA/s6zan14zjjIZZrE3lq+qK2
 jMEZTf+KX/g4+flzzrIGq+GT3qnRthnYECAkdwcs8PtFGX0bfz1p8b23xkyt7ktfzPGF
 Bq3PC/s8+90ZI/mUtkcHl17M04EdxqCZuVkiHsVrZFSMN6zMoiZN7tZ3UFe33hC+1RrE
 +Pk+hr7SOEMQKEF3NktpkaPuyZ5t03p2ukKbIKaFNiYPRyxtJfwWuVYHXSaE/I2OiqlB
 6zXUMeAiaECcRfuQmpLM4kfbK2JMCNXMok4Ty5dnRhxEl2XG6otpXE3A0FR1+xq+/1i0
 gAhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790579045; x=1791183845; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QcQk7d4pb6MSovoeWWdDkkdL6cfWPIu5znyjI13+lN4=;
 b=ScIplp954QtrwqJknc2wYvotKuELrLYDuUq7HV9THID+1AD71m7ECBKSgHUJ4hg8bp
 A+cuQyiUrWcyXllZb8T5vnB61o1GTUukE9v06mRhTcEY83Ytcwh3LGQV7Lm80gFTmRxV
 lEYX4TZhbMb53m5ZKrxkbuVv/vyrzj6+wJXIIMpRJfZM2ykHpA10wpmuDOrurPlaJWkG
 lUmYqI+3Ixl0Rp0sbqAijkevlW1DVfs37vyPzcUpWthyw2ZxJDOVmY6lmSKGyo/uPIPv
 uYRPVA4mPipcbDjPQLsiRDrvx4HwHRmAAWieNpDpRM9X2cxQcNC7XEchhP1foSiyLq4v
 Kx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790579045; x=1791183845;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QcQk7d4pb6MSovoeWWdDkkdL6cfWPIu5znyjI13+lN4=;
 b=rqk8271EDimuaIvmAB0Z+X+XYooJfDnmXnc9ipYijsZPw9DvGj8TLRfEt6GSpJP+h2
 i2yzxOvU7VGa/dDvn9WFJgIcqshQgHkMukDUENybm2vmBLHf2S1gPpe2qzy9VyJ0xy7J
 DsbRyZPy6K9/YuQF6AEaG8MvTl+z13p/MKJz6A/TIw/hj8qW14bni54YXFan+dZBozJx
 pUI3UFhc5OMqPjCQ9KKew8T6LRrlhBM9TljopqNjTElJBNvOhCA/zk73cIdgZdtiVCVt
 QfYs4qxbi1VZxy58hF2X3RobY/5CtvW4jSoYV/NFA2RXY/SRQdJEmG8+Fo4u4W6kdBM4
 bbPA==
X-Gm-Message-State: AFq9FYJIdDIsBmuhQIujA6j0UTt9ILDzsUcM6+rHSDLq3LBWt7ee7rS1
 74GC90/Rrpke7iaTpfVDuAtf55GiBnDImwzFZqGaFxRsM8q1IpSPhM7APlBTgHzrra3rHIUPmhU
 EngVUC+10Sjx5aneRtW3Z1PLcYAV+9QA=
X-Gm-Gg: AYBFou1ybIqoZt/BOq5Mp1K5p+vhzTlJyCfdVArsSvhzPh8M5ydpcOoeMPB6DHzQhg+
 d5iW5b9K3Q0QGzCEvoTh/9z6zYUmwitK/trf6N+D0rmE7b1/cybwNutRuLKabFvhiU8nc7F5wxl
 TpYXCZk1kqr3fSHOjzzLW07txCKtXqTptfmIbMX4JHM9E1khhw9d+vXIgwX5o67maipn+2WvePI
 Mm9EWv/l5mWUxxTL15oCvWngsNsXUf9LYDOI9xjMyaD52Hwc8kQhw9/ARmmxhxDCoY3n3jAd5Iu
 k9ItVvH0iXWJ7BgBoVLobz1hDuH3nHp/pFARJPTV+bOsSmNdRpXSMIYxazSKTPsDJwacVSNlQ2J
 Aqq7rJMZYkp/iPHYuaX6/6UC2kAPZvyuUBmcRDXKWQwN/4As50nAAEgBxGd2lB2jYXMNSrehMvw
 o=
X-Received: by 2002:a05:651c:1543:b0:3a3:7682:499a with SMTP id
 38308e7fff4ca-3a63c0e17d4mr34085851fa.15.1790579045263; Mon, 28 Sep 2026
 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
 <20260920193944.110983-2-kieweg.leander@gmail.com>
 <20260925-fabulous-wren-of-action-89d266@quoll>
In-Reply-To: <20260925-fabulous-wren-of-action-89d266@quoll>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Mon, 28 Sep 2026 09:03:53 +0200
X-Gm-Features: AclHuK8i6Zs-z628GgSRbUV6-Mg1x9Wm9seahXd_0HLR7cUtIg92sLhwtNyE8EA
Message-ID: <CAMwcS0hFC5U0T7WBURXd0tGLQE7yE+RdB14_-rFP2Y0fxv33ug@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: Add GlandaGPU binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
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

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

Thanks!

Best regards,
Leander
