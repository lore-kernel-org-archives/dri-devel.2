Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360DC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376E810E664;
	Mon, 10 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ry4+lPIx";
	dkim-atps=neutral
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAC810E069
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 03:26:41 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso323827a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786246001; x=1786850801; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+2ZP2VpD4hdDzBsnG2msnBM+iMSdLsJB7PET2eMgj0=;
 b=Ry4+lPIxU1gqj9k9YYdXLWjd3UxqIquboKyWvjqOgWsa3X/Sw+vMJ1pD7PI8fph+lu
 ZiTpgQVLrwgyb8OqN9KAvB1hwP3n1uYKbotFeVYlLgVSc3bPaN+h2RuvmyMvqCtVHDK8
 Oqf4tZQ0uGVwo87yIhi5TVvS3P9y70PTGVLyNsS/sd2PKYEezDBNrULWaHplpq1P7tsy
 U6M1GFwaGux/S8h+4Sd32Bf8JfKjQRf1tWQvyAAmVWXZpSgGfcQ3nhUZb3ZZvtiLu776
 s0JHj9ir8O0/2CAEw4iF4u5YGuesBGij+of7TTEqs/fu8KWYe3pAbLSFkTGNIzPoiA8O
 HEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786246001; x=1786850801;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+2ZP2VpD4hdDzBsnG2msnBM+iMSdLsJB7PET2eMgj0=;
 b=i+P4Ui2uqTFSY/xkCWFE7fs+RzAbnI8ZdcjWuP4lt0Z5wfLsc0Lp4sf6rZblyILEV7
 +Yciz/q1JvBcFHfsvhyvyant/GoSu8c7qxWKkeHj6eHAJWi+kMEmqtRxMqLoY3Kr/HKM
 nUONnqndJiNb7+kT3AQtzi5H07I5orIBXqg4L8RsIABoymwoC5wqM9ONbvJPJqPs3KN5
 sKpbjqupvc2P5qvOIht24wTKSg8m/53GTObR5M3GtfWf49PYrcXt3kNMChjOjTKQ7xog
 gIOCTOf/AZFR5vZqsF5+I3sB41YiUFjiFEsnCiC8SLLM2oRmiHw8o1DruQ+JWK/q7Th+
 gMXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeMzUaa4SgEbWZFax1nVNEYpoctB65EPxp5jg8bd+cGi4pq1sFVEtCwZANhq+9xXa14FEhV/g5lCI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWnhdXvQfOCXQ6MWAGuhrcU249mU2aGodrWcprgLGOkX/okyIM
 GTk32Mbo77GVya0iIDa2lX1bOtupRSaETHeL+rtNqeSNv1EWstZN5n3r
X-Gm-Gg: AR+sD11OPPrpTPMAHtaTzqOjhMhmJE6utu7jkf6ZOw8C25bbQnOtz0J7tEwHBJzgqNp
 yYjbHPwbM11KowN/lIZtXTvbeC84mfzp7aSBKos+K5kLgchXkPSKIgD1P1Bwjo1gp3Ilia1ERAx
 bqjciuPQDFozPZ4G/x+peCUoU5HW8p4dAV4ewcd1HYtY8blFGFx/uUe0k73l/S9mvu9j0E447Fn
 oUidr5HRwFEY1wJZOHpfVQf4QQ+ibaEQwT9FZTCE+K4iwYa6rso8q1gkxLL1D+rTuR7FXaALdVJ
 OoNyu5HYxlkWRb4JSCIGA03alnlH6E6FRy0kmbAnwb6WBPstnIKmGT8s45Mb7LXQkAQd7Y2c7Om
 cz+ojXDZRgUf/rBpflnWwthoLph+h+7W64Kj7gjU3yIhQBocXgaZX9scrNNvDhcufx4X4EhyKp9
 Qemc21FQ0XZaKEfE6yjjETT2dyTupOMA7xuw==
X-Received: by 2002:a17:90b:390e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-392823ea541mr9657081a91.16.1786246000598; 
 Sat, 08 Aug 2026 20:26:40 -0700 (PDT)
Received: from localhost ([2403:2c80:6::10db])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b35ca2b7sm3210539a91.4.2026.08.08.20.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 20:26:40 -0700 (PDT)
Date: Sun, 9 Aug 2026 11:26:35 +0800
From: Cody Kang <codykang.hk@gmail.com>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline
Message-ID: <ko2cc6jyezfyqzg2rdftyebeydw6nfd65ajvu46acfewhnrqxi@om2uhqdlhmzv>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
 <084a860a77f18aaafcda4b223eec4fdcd96e75c9.camel@pengutronix.de>
 <wr3264hzlya6zep433nr3u2acukizilkrqpkj444kfqeyaeorj@2rc4zo2cqcer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wr3264hzlya6zep433nr3u2acukizilkrqpkj444kfqeyaeorj@2rc4zo2cqcer>
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Sat, Aug 08, 2026 at 01:03:52AM -0400, Guodong Xu wrote:
> On 2026-07-27 09:35, Philipp Zabel wrote:
> > On Sa, 2026-07-25 at 00:51 -0400, Cody Kang via B4 Relay wrote:
> > > From: Cody Kang <codykang.hk@gmail.com>
> > > 
> > > +	/*
> > > +	 * Assert before gating: a reset asserted into an already-gated block
> > > +	 * has no clock edges to propagate on and leaves the register file
> > > +	 * untouched.
> > > +	 */
> > > +	dpu_reset_assert(dev, "lcd", a_crtc->lcd_reset);
> > > +	dpu_reset_assert(dev, "esc", a_crtc->esc_reset);
> > > +	dpu_reset_assert(dev, "mclk", a_crtc->mclk_reset);
> > 
> > It looks like these three are mirrored, and could be handled by
> > reset_control_bulk_assert/deassert().
> > 
> > > +	dpu_reset_assert(dev, "aclk", a_crtc->aclk_reset);
> > > +	dpu_reset_assert(dev, "dsc", a_crtc->dsc_reset);
> 
> Is there a reason these two cannot be mirrored in order? Please double
> check. As I checked the vendor tree, the suspend/resume side appear to be
> copy/paste rather than a deliberate ordering.
> 
> Please double-check. Unless I'm missing something, I suggest to bulk them.

Agree, I'll check.

Cody

