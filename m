Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671A60A6F65
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DHwLOvwB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB64410EE4B;
	Mon,  2 Nov 2026 13:40:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004A210E623
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:42 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so32286855e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626841; x=1794231641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJboDKYLD5odXq2wMgxBJknNJQ9cln3HeP/apn+7A4Q=;
 b=DHwLOvwB5KUVY947C+Jw0Nzik5mvB30sMf8IkXc7zmWe7+9arHe+wLCbUp7nZ6eUeA
 JxJsihvkAhnZf9UXI7xpY9uz12fnjmSlwHvRXsocebvNZ0VPH6u3vQMEqS+GXsVd2iBO
 5ozK7czjb35ROKBSz0sYfhmldgS1VtpTBXxg1h8UFlCFzULQVuQCTZwxNI6x2a7LIgBu
 jGgHK5brbvy0UBfF2bMPkAEmEy+GWTXdnGZZNoOkE3YBfD5qEV2urUQ7jYiq8NJPDeS8
 PJSKMHxzifwe8meqExrpBVUv8N9pVYmo2TpaCc+ev23IKupryGEH4uiS/pPqyPu8kPv3
 uSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626841; x=1794231641;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RJboDKYLD5odXq2wMgxBJknNJQ9cln3HeP/apn+7A4Q=;
 b=gF98leSQxDLb76tr+vjDiVnFMs3LCW2+S4KgmKTnlCXYk5TT9p1tn+tAPTwuxOsj8r
 mUX5osG4IB0tYBwUZHIVUiPQN303GgWUPGeyz842OdQRjQBlGTz3+W3tRNg5WU+ZN4t0
 FP9DfNP7945SDSKhgTaK6RBpD5oq73gkzisWy9IWhjFgizVtURO8zsGM1ZRaO+1RzSi6
 f6cp5otOU1Fo3XzmtR0VnKFxP6kwo7WozG+CBNI04tSHRO5nntw7w78eWbcsXcy/piVp
 EipvQkok5sRIvOolExuqbWAODdg2QZE6HucyiNDO1ctNgBmGFw4/WeVBIqiDNsfbocOZ
 tBbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/AEItondiHUaHUx1yYx77wTDpl9x7oa7t7FYZwHHN7P79OJy1b3hbWWRYqCQxj7T65LHnCcCGMVQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKPxMPd7P6NRq0Lw9KYp6vwN68XUEsK9VpNcQ9QzmzVGxY0KCOO
 QGpgwXIq/REh3Hlcmuf6w3wpNbCmLeYMzuQroAE9TmG3DXWo+RahnFR3b7OWXe5j0AQ=
X-Gm-Gg: AYBFou08MEgH8A8fGoTpNwc6KkHkEkfZfcSBPwFwICmqCBLxDiPYGyf9vAlKth9kLr1
 tkotBJZSfIG2vRo6tiBj6jsHQHS6abL1yidsnxxIBYCVIEF9rzPE+9xLJtFbfm8JxyUq0ZNBMMO
 UfE2lkI26CAvbA+WJ5/cqZvPVc6NE14OS+9XKnzuZtzaQax3Xuy39W9RQqEvx9mZFw2LLwFNR1w
 R+To6VBdTis7Gn5px99VfwZPO2/Orf9xkBOJ1VE2eJ7G3Gm8CgqTbRb+7UleEiBYAgHko+6Up5r
 4w3xLa+p6qO8sJP5oEIkn+vVe70Vs/fkk1oOcvj+7Oz+q5JD8rgm6clX8EyTPCbXDibyG16dVWv
 MXRTPqJKAJ35IWeURbLh3QB9haWEWeCVpH/mrDGtRpaC7za9YVqiKcTyce9iTfI8u4a1xPfyiXs
 XvR5kZYzFeWEHDaZk4vywrj8qXrN4Qdds3hl8NDBSC49H8P8kK6rYPP29xOizCYqbPBtsncU3AG
 cdkVg2//QrGbUYWoSVth93JE3K3r7EFTIUOUw2C7R+d+zTzLc1yWm0iyTU1aK7bJW1D9D8DXB4S
 2AUSgGYgDXxAazSea3Mhj8iMefqZV8aIAEe1MN70GX+WPleavA==
X-Received: by 2002:a05:600c:4708:b0:4a2:167a:c93b with SMTP id
 5b1f17b1804b1-4ac19234ad8mr231192185e9.30.1793626841264; 
 Mon, 02 Nov 2026 05:40:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>, 
 Aboothahir U <aboothahirpkd@gmail.com>
In-Reply-To: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
Subject: Re: [PATCH v3 0/9] drm/panel: novatek-nt36672a: Extend with 5 new
 panels
Message-Id: <179362684012.3310106.12925421623133714405.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sun, 11 Oct 2026 14:54:01 +0300, Alexey Minnekhanov wrote:
> These series make the driver for novatek-nt36672-based panels more
> easily extensible and add support for 5 new panels to it, used in
> 4 different smartphones, all based on NT36672A:
> 
>  * Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
>   exact model string is unknown
>  * Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)
>  * Tianma TL063FVMC43-02 for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
>  * Tianma TL060FVXS16-00 for Xiaomi Mi A2 smartphone (xiaomi-jasmine)
>  * TXD TXDI600YANPA-43V3 Asus Zenfone Max Pro M1 (asus-x00td).
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/9] dt-bindings: vendor-prefixes: Add Shenzhen TXD Technology Co., Ltd.
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9f6142a00d86df12120562c27e82c73cc6d30862
[2/9] dt-bindings: vendor-prefixes: Add Shen Chao Optoelectronics
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b55dbe9011975146527b8d371f5cd9a36f03a446
[3/9] dt-bindings: display: novatek,nt36672a: Add 5 new panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1123a125fbdff4e220be9d7e1613ddac2a32f4c0
[4/9] drm/panel: novatek-nt36672a: Set driver name to novatek for consistency
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/109516c683991707a4880ed26680c45f0ce4cce7
[5/9] drm/panel: novatek-nt36672a: Combine two init callbacks into one
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8a834378028bf53a7bba729681afdd350a1169a2
[6/9] drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/df9c727a0895f3f27d8cf8f577a32f5d4620bb63
[7/9] drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c13368a4f3f9206034ad89dc979935b0226c48db
[8/9] drm/panel: novatek-nt36672a: Add panel for Asus Zenfone Max Pro M1
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b6b23fa0fa46140c56cbd3886f4c4065b6fec761
[9/9] MAINTAINERS: Add Alexey Minnekhanov as maintainer for NT36672A panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/46c59e358a47afe5f3de9df39d37f588c5f6dab9

-- 
Neil

