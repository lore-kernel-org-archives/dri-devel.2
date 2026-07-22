Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D501C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED1B10ED74;
	Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNttbQiD";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BFD10EDA0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:15:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4955484387cso25211385e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784722539; x=1785327339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xw4PW534JRt7W+7M044jqZN3M/EBMZUMhKAoOTNL9HY=;
 b=NNttbQiDfaNfribAb2afxvutiEb13HObMAO23Bl2KqBmc7+IweyRQiygm5WcvFRS6f
 DbA+BJbLNtp829njVNbi0LmORTpMQMWtEAtPfDFV0SBwI7Sja4FCH84XyXGd48GShU9P
 PBnwDeUCm0uqF/ZajTGqJAAqujukxbYuTL1hCqgFmX72fxZquUDd86WHGd0/1xODsbZt
 DKMobQTJZI7UFzWnlVev5lFMp9HhDMRuEyxBZHB8lhORt6JBu+RHVXnLel9rcv721K1o
 gdUWaHzgnldvyKxk/xq507jnTs9tarGtcUWniUvlS2pk9Ys7Tbwd2qgMgcoRVKnGVsKq
 XqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722539; x=1785327339;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xw4PW534JRt7W+7M044jqZN3M/EBMZUMhKAoOTNL9HY=;
 b=fWkbz8c9kDn9+9+ow7pv10EDRscBJbQF/sQIZQEP5cDIJflndo2yNCwLkpfA8KbifV
 m8nl1gjE/UUosgIpVBAI3UalbWUbTmU6J6bG3pQhgW9iImHPJGqImiW6FMB8KcsmwAR1
 u3mBxdOrONPaozXBznKInZQ2S4nRN8Oc+M7LKDLQ9NKHblvZIUw1winXBT1RWAk2zGdN
 VzUqKPqztwT0ZBo8jMgjgV4tbF7shZjwe90sGwDTZGrfXi7hQ9XFbOeglnriuXprK0WZ
 2icupVAx1DKzpuEhkFj6a+VaumUJ/ZZ25ML2pOQ3guXj1h0nMj/aUUz/8w8pr8FIONpE
 FAKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqI81cNhb3q5IP08LW5MdKPeaEUgb0RHD5n3sybyJSCtR6UtYfNTsnz5oJeQByW5MjnWWPiMP9PT8E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/Sn0nZU5ZqsP2hPHfgmpMzQXcTRN9gmZloOWZkHpXwAHdpcUZ
 BT1hf4BfddqxvPuBSxysbvk5G+yXZJhqi37rahD0eGl6r0sY8t947CMBGzgquMB9aGA=
X-Gm-Gg: AR+sD11fPjohatPV/WJNlguZhfVtSPzPv5f0K+Ux0+6g1qTydAnSg2JkTtwUeheGbYw
 arP8W/2iJHC0oN0u84EpQiU7KFRcWYfcnkp7vBU9ZtkBxWIiZG/bxVtVna2Xxv5/hFP/o7Py+6s
 xi0ffe6uM6OLDlCyStczUDqCEc/J7MsmnxRVGCPBy1oPie0MB+cR7P8aimBA9Y25UYmWZmdxWEf
 0mWd1mOMG3ZyZ2NfHBHdzoCThJnzjFv3TPUl1g7BXVnGzmUglodotVPBVGFzM/qx1X0UeNF7RNV
 WNQ9mOeDK1cO6D1SKbcHq7APupBqdfxnAH1MiG0vCiKB+V635HscuhXXarcIfvjGzijsYUXNDRi
 LlMhiipPsFBFgpFp5+XvAJ6pB3UcCyXd/oquIhw/nHjS1zgq8BNO/G4NmEKxqjRy4uWR6gdmbJS
 mGIzjm/vppUeNof2NuqNk9Exk=
X-Received: by 2002:a05:600c:4753:b0:493:bc4b:b8c with SMTP id
 5b1f17b1804b1-4954a413024mr250331295e9.38.1784722538803; 
 Wed, 22 Jul 2026 05:15:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm4379093f8f.21.2026.07.22.05.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:15:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: Add Novatek NT36536 panel driver
Date: Wed, 22 Jul 2026 14:15:14 +0200
Message-Id: <178472247749.1745070.8996806935280043926.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709142846.12463-1-mitltlatltl@gmail.com>
References: <20260709142846.12463-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

On Thu, 09 Jul 2026 22:28:44 +0800, Pengyu Luo wrote:
> Add a driver for panels using the Novatek NT36536 Display Driver IC,
> including support for the CSOT PP8807HB1-1, a dual-link 10-bit panel
> found in LENOVO Legion Y700 Gen4.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Novatek NT36536
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/38873dd52850c3d713f006c240a2ce0abad52271
[2/2] drm/panel: Add Novatek NT36536 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/75a5dbd1f4f71b1382dae973538af00178ba55a0

-- 
Neil
