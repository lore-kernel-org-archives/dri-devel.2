Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C53606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2KrgwhE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB6E112050;
	Thu, 29 Oct 2026 07:59:12 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5953B10E6C4
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:50:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so13630485e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793206239; x=1793811039; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
 b=j2KrgwhEsff5EdBemBOdDgqe/DBPCvYbliH3FvbQ32vCQnfnTOu/MHpCz0uIzoC17u
 us9rqJVo5ibVlHD6OPhCcpmtsXk0/kfLBCiMepHWDv6QSsjrRdt5iShj00tnnLfihRti
 GvkXfOGd84PGeqSqraVtjcvsGY3EqEce43qn6eAqoo9Ao7lBSkoLncyRuBOyWsE/okTZ
 +ZQA2lA7RJ9fY+kZeSHYKRvXcIHW5TfMnoK6sYg5vo9iRwBFywCHzt0OvsMMIzckv3UY
 w6bXqBz0I6k3d56YSnIhI5A1E4Z2LkVwfEvutE3yfn+jGUZenv7dbOKjxD9L3T413myP
 UPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206239; x=1793811039;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
 b=S52B5m1xKEw8YN9CtpixfGhdyBcZKVCWioAsCsxjUPhAEpZhROdxU5waSsVkD9jYuG
 JZkxOdRqcJx9C8bnhoFPatFNtm0YhzlrZjqJlBNiOze6NvRjIzpde0Fn5920SXWaxZnn
 r6TYOiE96q0oDGdD8JbLaUD81Ax9bwEMnahcDuo/PjlbnirwFgLFJFYi7uXTQpFi2/eT
 R3uC91EQWIYEXWv8sROI4KETnFiLZPUEPBVYvkx+mZQaKaekT+5ll8hBCAaYQVNAP5mU
 j27MkooxYC/DDuxx9HXuiYOBzgIdxGMjOOcgOoapZDj+UivS26STn7jG62lcd2ZvJ9pj
 km8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5FzQZ1k1Sc0lIlQinWq6n3mO1bJ4rD+23ovlp+50aIqle0Ao+fB++s77FzN9+P9b/D1f6kPGSdZc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBGM9Kn38EepqhKBudE2dA81e0Jr87ANcSbQ8JCVNccVrzxDSy
 5sktsqfbho3j3Sggsv/jP8IOzNqe6YbH8IKn/dgLzwzo8Zq9rGNer81t
X-Gm-Gg: AYBFou04KBaDYlpclwmZ1Do0hG0sHF3Wmn43owX9jYnfNGTQXgRd7CDeO4EOqyrCKV0
 gLTk1xuqBhYM5J/RWAnKwIIjaed9mzQ0NQVxg3/4SWmMxI3jMqhtd/lcoknEvJk83DlDj8IoNt6
 dcZH0ueAMB8e2xWroJhANMltUdblEJYY7kmV/X3iuK3eE4fvDIcj+WL3fEDAs94guls/gvtwDBV
 /9KyOaLWmq1WhUT6oFwbtr3znB1+TsSu8yCAajelFkSGDHfYY/P0awftejKriIuPCFrevz9ocxW
 PRdl1EdLTqWNLY/Zv1Ry37a0EFriioVdubYmqMZyHKKJfrEUqXIYLx6LsZVqDSFtHmNYJmK2B+f
 /nllaSDfewG7Cv3SoMPwVpgvbZGlWvrN1xE8FJQ+Te9N3+STxM7dB8fC0iHEQTwPXG5FXmiM+/K
 JH9Z/5F44O7aV/mWettTW7ogKN7p5Am2cV3Arl9KmjsbIVUbrBlnaUl8KrEYytx7gO7I+yW8LNL
 iDHgY9MYNrSAmVI/KOfgXboWz6pcsMFUGq15GL5WctvOuLFhQyEhr1PBOTFqv3zmY+QlzsvJFHC
 ywBqa1iRPqv4olKyrLRKl8608m20jb5s//gYR9NdTyFSQ+dalyQGZE4IE8E0M86cRyPqSELJvAt
 a9TFNrNUkbveQ2oRs
X-Received: by 2002:a05:600c:630e:b0:4a6:7d6:821f with SMTP id
 5b1f17b1804b1-4a9678bff9cmr62960175e9.29.1793206238343; 
 Wed, 28 Oct 2026 09:50:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm29895785f8f.12.2026.10.28.09.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:50:37 -0700 (PDT)
Message-ID: <6ae227dd.6c7231db.220083.ae75@mx.google.com>
X-Google-Original-Message-ID: <auIn2SfzeFL2CJn-@Ansuel-XPS.>
Date: Wed, 28 Oct 2026 17:50:33 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Anholt <eric@anholt.net>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>,
 Aakarsh Jain <aakarsh.jain@samsung.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
References: <20261028120216.2657397-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

For KPSS:

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
