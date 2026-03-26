Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE646106F30A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A014110EA26;
	Thu, 26 Mar 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zNhhB2pF";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F31810EA1B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:39 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43b87970468so652066f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515758; x=1775120558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBXr8aiIFTUZuAj4juafQ6eTiNge5AijolF1/+250O8=;
 b=zNhhB2pFh21rx2PZXPp+BexP6bcbBNCI+wKcNLiQSwCMtuHdJOGwYjabjyXq4LbSVi
 F6MHLgHSU3e7cg/F1OqHIssy863Zeq/e4gZ7MvyrjgRl+pGjV+qUiISp+VNNSLX+Nl/E
 6DbpQCJxnBc5qGouk/T5D10d+UVA/lbQO963hwf5U1qXQpedzcOMIjp7jO9y3SUW4teC
 VZcDQOJtQamL27BnM4awTipXgcGmVQA85qTTg0Eizsmhrc7+ARy5KW0xwZP4KzRAswdC
 cV+tFBY/97Sk7lW+V/Xj2uRqsf057IH2KsRLcpnCBvvL1PdV4xGMmgIVu7GzvCC6Rinh
 DAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515758; x=1775120558;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JBXr8aiIFTUZuAj4juafQ6eTiNge5AijolF1/+250O8=;
 b=KIf3dUJONYrMII3Zn78tm4WHTlO4JO94hWJu5xNwGpf0bh76PnbWlM/SycR6CCwNgv
 6Cgd/Pl8ebQil09EEhS3cMsK/x5gwL7ZRfn5FbPr1N0B5RKNrH4+96ge1jWo7ctldxk6
 VnzcWYGlKP4YDVnQAD5R9tpGA6YCE7ufzZF+pr8z40RwmDnZKOVsPQ5Y/HHgCtWq52G4
 VC2rzDCNGWW34Z06oBCbpmNH3tombqKfBWpQBZe02dLIvAAZz/G2gw7/Jihv1T3Xv5sx
 QTL00xsy7vxSzVJEpf/G6h5eAKwcWhPhkCLy8XE2Ic3Ze/p1FMoM6fRD8Z52TeBlTXkd
 ylEQ==
X-Gm-Message-State: AOJu0Yw2z7mU+aj90vkOiaqbzQhHhbyClm7oqRbJzyjw8RyazhBRRZmC
 CPXRHb/KZfS2ovv0iRBwrJkapVTgT6JOeyItkmLr/x/FAthP7YBneuDbuk8rJAMAVJg=
X-Gm-Gg: ATEYQzxVF35AvGwYoI0V8X2VvLXpsSf1YME+IxH8z+FdYWPTpAaLERs3UrRAm9CD2Wj
 WrTxI3jfS2mpH+Y8aIOh8hJFOgBrqtW7VxKE4Gt1oldJjrhJ0BTBFKHZkz8andoN5An7yjTXENv
 EFJ3pm3LbU8uBzhLhtkil558YS6+d9H8rK47gzi8BrLAJNPqpHo35729jMl7/q72cLA9ST0Ceb/
 Ho7eJ8Tk93isUVeGaTKOk0rYDtIB6UrdjHXLTiqV2jisFGW5xb0zM3iH2fvulrnKyuuREB9FBiF
 OPhCeFj1oID9LyHpOYhIiLT5POki/N+7zg8PkMrmZw2VXhD9YEUBH9HuXmsnepAbk+SI+jryPh0
 o4k960DWM5npbz2eyVw5KWIYBysUpzp7mB5/5xgWfIzxvbV4zimhepc1bPsNoyqq9kCzkpWKpGI
 0/A76xnAMhT9HmL89WvNffmeDhTrzq7cVG2KQvKo8O1rFI
X-Received: by 2002:a05:6000:4381:b0:43b:5672:f02 with SMTP id
 ffacd0b85a97d-43b88a21651mr9446438f8f.7.1774515757311; 
 Thu, 26 Mar 2026 02:02:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260227-tianma-tm050rdh03-v1-0-cab78a0d765d@nxp.com>
References: <20260227-tianma-tm050rdh03-v1-0-cab78a0d765d@nxp.com>
Subject: Re: [PATCH 0/2] drm/panel: simple: Add Tianma TM050RDH03 panel
Message-Id: <177451575633.103892.6447334115682861197.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:36 +0100
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

Hi,

On Fri, 27 Feb 2026 17:31:34 +0800, Liu Ying wrote:
> This patch series adds Tianma Micro-electronics TM050RDH03 5.0" WVGA
> TFT LCD panel support.  The panel can connect with i.MX93 9x9 QSB board.
> The panel's data sheet[1] can be found with a random Google search.
> NXP website has a link[2] which contains a picture of the panel together
> with an adapter board to connect with the QSB board.
> 
> [1] www.jetone.com.tw/uploadfiles/327/datasheet/tianma/tianma-panel-tm050rdh03-41.pdf
> [2] www.nxp.com/design/design-center/development-boards-and-designs/parallel-lcd-display:TM050RDH03-41
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add Tianma TM050RDH03 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dfefca41a4d38e8ddba78176978d679d7af01ab7
[2/2] drm/panel: simple: Add Tianma TM050RDH03 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/310b05505cc346e091ea6ab0d2cab0663855500a

-- 
Neil

