Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D1EC9831E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E062410F5C4;
	Thu, 24 Sep 2026 13:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iv4Vob0h";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FB810F5C3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:59:32 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so11997945e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790258371; x=1790863171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVb+5eFFzuO8SrTG5231sDQzK1ApgWpQTmIUYa2esqA=;
 b=Iv4Vob0hK1gAYfa2Q8ml8YLAnEsCF61eosd440u/LY9RYweGUV5+AilRWZtWCHMaTu
 qo1WYKw7yZ+lRQFVET5ewpZoEQLLwW/HJOWp1AQAwRkxDyyrtUaanDgxftdYlpaYbe2p
 4X4hl9vvLXMqm7yKNTMCoQaRARnifOudQKpd+rZ+wCcNQdgeSCmPt2WXM8M5kj0Q6P+4
 fW0EnJzH/SHfJQ5iexJ5ywyf0Ic1TWCTLiciiAIurxuH86y+Xvkf0E1OyG2opfGfrchu
 2FgoQMoVWlEwC3Cb08/JcNcfaCLksyLtlmKQUavNXnMWn8fUvhKPOlFysNMZUjncplOV
 lCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258371; x=1790863171;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVb+5eFFzuO8SrTG5231sDQzK1ApgWpQTmIUYa2esqA=;
 b=APjVyxRUQGtDEeiULMuY9iw9MwnxrEjpydNXHxCBr5rPu7cfD+MkZS9tp5eZpHX6CQ
 geRHL1l53h3cmTKEpu1duAgZrRjve87lDFjjyOghDfAxgnI0K3kO+bwEMG6SGoh86yzX
 BVsHgCISpqZPryOFyzLN53h1j7NmtwBbnS/GOCNEbIEyJHm90PGyr7bTaPC9VHhSrjtl
 XlP/yVwKnkiTnVw9+G2rG74wjvx1nOzncNzTrQr1QEE9MlKpQi876stTbH6vo4qadGOB
 ARxF85XSJu3uysBtg8TVaE5Gniq6jyVtHEfxx237mOgle3EPJXNGeK/c7Ihbl0cMj/f9
 LODw==
X-Gm-Message-State: AFuF++lI1Fk1B4lkwyeT4R39aalCY9bh4FiRrNgEISCiAtfVf8eF/U4E
 x7IHNmCkQL9cQpi1rBL1eJoBI2VzsKrVAaYmxX+wb3OI9kpvDQ2wYBGpF5euOASu2uQ=
X-Gm-Gg: AYBFou1jrj5POjwHDGmsgit6s0w5qOIzpCGAi8HfZtqFSnhZ8X+fX9+tAOcsdqmTDd0
 LmsfhEuaOeRS5dUXpmDh4VCtV/Aobnb5UyYwBQzTPlOOZiBolnkKHSC5yAcENTPmWGlEGGqOLh7
 hMFkRnVsiX32B0p+Pp/oFafPPcDmuJIhTsZOTXLEOSkzD8v0b21PpZE1H9OgmUpiy3YhkoHlbR9
 JwA/7dA10q+cB3pGMJqhS+vxvE7OEtIIZfCStDNPT4deYlRT6yfNUWTaugr+HZsvQoEdkhPk2PS
 2VIMxkreztNr0xmNJwIsBn0wWy0SiEvQSgYW5Rlx4xROEwp76YMPTxjy1+83ZluQGhRfvYnlJzI
 jL2gyN7Tm6nnNO43PyTKDlM6ENyHRBD2HpRWVFiul0tGXpkNMdI1gdX/eTlRfJrwyZ31KvwL8aS
 MeauA8zpMlmk+37NBqo6Y+PoKXd7M1eHE+ZnVV12cdepIWGx2SA10/UuR594AKZL4HQkB/gKdvh
 TomaM8orxXxb5qBdmqU
X-Received: by 2002:a05:600c:3b01:b0:49f:ce78:3570 with SMTP id
 5b1f17b1804b1-49fe670bb82mr41434195e9.33.1790258370793; 
 Thu, 24 Sep 2026 06:59:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm15799213f8f.19.2026.09.24.06.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:59:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Liu Ying <victor.liu@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
References: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] drm/panel: Add BOE DV215FHM-R01 LVDS panel support
Message-Id: <179025836975.3234093.5704563992134575173.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:59:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Thu, 03 Sep 2026 09:04:16 +0530, Vishnu Saini wrote:
> This series adds support for the BOE DV215FHM-R01 21.5" FHD
> (1920x1080) dual-channel LVDS panel.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add boe,dv215fhm-r01 compatible
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fbbf93ab8bcb29ea741b99e7cd9bc2120c2a52b1
[2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/92be213ad653a6b785bf465f0d259b4eba6d9207

-- 
Neil

