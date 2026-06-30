Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DA1C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F16E10E038;
	Tue, 30 Jun 2026 14:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktFvD4jo";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D26810E038
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 14:05:23 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so2638433f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782828322; x=1783433122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6LhOb8EsOqkumof6PN234kRqnlpHLJfaxXGP2ixv0M=;
 b=ktFvD4jo/sTluWyzOKiQpihi1Z7fPYsRRPbUqKvOjLQNKl+h9aYEH8JXQeM/Y3vnLI
 UaybV3Iu5X1igKdbaTDVYX3qB1AxzxIFY4i74TQni2fxlyS5ZCIRnk1PDvt+BJsoXvMI
 1CTA/vdQFD3IF7VEETQ/TavosjUl6Fc8I5SDziA2V/Lh5LOp2Ncc9C3xDg0qhfRVoItN
 SzkGe1HaEJfBNypj0I0PwIJIAHyTHkWQe+65bOSlEoEQAkqhnpfodPkW+19SMloH8u/6
 3YNzJ/zpcSfuSU8yax/qSd5cVl/WRAHtDrwZI72GsfX5xe6O4oFlIEry3lGodfhksJ1s
 Lkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782828322; x=1783433122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6LhOb8EsOqkumof6PN234kRqnlpHLJfaxXGP2ixv0M=;
 b=ZEzKo5z25FkhaR9qktb7QxNuqs3u6N5Zs/gjwN2G0h81uYjzoJippglhP7LZv97CXK
 LIS+YIrHIw9MKxrgs2U3Y5ZqKrIhKmUTHYqVG2vGVuT2BF5JN1wM9yvMXUbWu6o6t1cg
 hMRahjBLx0l4mpQlKgynOUd1A4I+Isx+7optysk23iFLqENJEAYTk3S2fc/mZj/bmsBD
 WJ2cr/hYIixXB1wLpiA7KIesNp5ecI2rL7DDZAIUaiHNoNSoiBfrre9sZ1MOh2+/mfI3
 wXjw1dU8qsEbQ0Kq/X+q1/mdLOXFV9qiu/uB2Nru/7hfNfHgkByqzDyjYpL919sGeucq
 BwcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9KEvL0MGsvzaBs8i9+aVTSy+KOlxrv79dcXft07k9x0j8peJVJryfufS62Es3YqVoksiqiP9mtZ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9pKqpFhGiB592AwjtY9QAlDSOMjMgMdZQhl0EleTxEkdCakyK
 ciUGaYDT63wwEyxC0WXgcingF3FFHxTql0SZ6umemEayMz2/gb8W4/oz
X-Gm-Gg: AfdE7cn3BEsFGrp4LrzdujBY68737X5Lt4xhU/Kgy37iVW/0HcAQ8d57ljA2e+p6xH/
 jygLYjUNqCzPINsWs09NgD+pbdPnmvs66hTMLgX9aL4k/GsZ+qxA9UQ6OHWOkVNgwAolhoaAAYG
 20p+6axNMpb0V8s9hsG8nf2SbaZungCUmvDsWfWAEIAdSZguBihUGrXcd3QlQK7B0tsnsQ9o6D5
 kJ1CWLHZeiPzsHfgvvOkFpLIhNaCVGz1kY9CmdHaeI3CNx+N50FdGhZdabg7Qo/q2MIw0Rzryrg
 gFfeKGNyoU3yOTP+YEu6iuWBe5BDOsRaR1fW5P28okkhLSsDS3j2kA2rbdjUpIfhcb1XHQjwZl/
 xJgbWiFzEmIilhBkM8pA+TK0t5VqH20N8rMHshQY/4vRiIWxyFgs4OvTtqGqyt3rP17GJUnKvtC
 GS0mmj7PWwoPX2WNPUks+4UF3+h+M=
X-Received: by 2002:a05:6000:2510:b0:475:f0f0:9ed0 with SMTP id
 ffacd0b85a97d-475f0f0a0d6mr2897097f8f.59.1782828319713; 
 Tue, 30 Jun 2026 07:05:19 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756778f015sm8456382f8f.31.2026.06.30.07.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:05:19 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com
Cc: airlied@gmail.com, andy@kernel.org, azuddinadam@gmail.com,
 chintanlike@gmail.com, conor+dt@kernel.org, deller@gmx.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
Date: Tue, 30 Jun 2026 17:04:53 +0300
Message-ID: <20260630140453.78029-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87jyrhd58b.fsf@ocarina.mail-host-address-is-not-set>
References: <87jyrhd58b.fsf@ocarina.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:
> Given that we don't have that, I suppose that we could just get rid of the
> DRM_FORMAT_RGB332 support for SSD133X and just default to DRM_FORMAT_RGB565.

I see your point. In v3 I'll remove the format_rgb565 option and just make RGB565 
compatible screens (ssd133x and ssd135x) use the higher color depth.

--
Thanks,
Amit
