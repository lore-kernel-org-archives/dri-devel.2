Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341B606A330
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nbEDE1Tm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E759B10E623;
	Mon,  2 Nov 2026 13:40:53 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC03710EE55
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:46 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so25672985e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626845; x=1794231645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dl78OSEC2a8P0qNwjbCaKAfKyZ4r0+nLQbHmynuYPGc=;
 b=nbEDE1Tmlv56NYLaQrWamrWQORhYdlbSXFJjNBM0VUysZbqw0+25ntezSTI+86JOtk
 J5nY9rtYWLSjMLjw0cbMGrL1rHb4ehHLQZJRKjMT988ZiUso72a8HSYJkWawdCWdIpCp
 oh5q4D7N86C0XnEl0077HORqEvGpjdqIxk3jpFqXQtEnIyJd5rWwrEMzle5Nf477tdu2
 G7JhuR9CqvOUHULc5P/LC0ZrolyPzlrIGE2uwn2HtW7Y6D98ZPpiM4lXwS/lBFDGn16Y
 xTwFdV0vbqwG3IEYeq+03bUYzhCIxN4xh+cu6bgq/YVq/FIeXMVtAtIwW2uYjjDpv2Zp
 fjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626845; x=1794231645;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dl78OSEC2a8P0qNwjbCaKAfKyZ4r0+nLQbHmynuYPGc=;
 b=N1PrctsWYV+t2GGTXd1+X6VVCIHI8kxNtA0vCFedSgQOa2U/N/bBJMakivIs6KF0u6
 vYCqDiF8/wFLX9hBi698TxbxjRt34OJF8lWdDTktX4ktAjngesoVsa5L48BYHfg5nyUE
 XA5whYIBhDqE61PuH5pWhVWYJcQ64egD5ZbpnmXwVqxlOiJ2eirzyaAAZJsV7BQ4ck94
 OXZDKAyKEArCDbIX6biObCeAzACPWfT3gHP0OsWbiLlE6BYaOCFR6BhDkaZe6kR6qpM2
 2OYG58OKzQr7qoPIOc8mXpZDWHxbxcXkpEvfFYbDK4oD5TakWnnu92PYSbgMd4I6IfbT
 8ayQ==
X-Gm-Message-State: AFq9FYL/WqMnygm/K6fuc9rpOWzP9LzLiOnLohZ/ayXU1fHkb4b7cW5N
 CuuJOMxCPw8qyMg0PBkrh5V07Go1PS4J0mEG40nXjfd9WeHdZz6x2vg2UAPU2mwV015NOQKSjyf
 /MGGq
X-Gm-Gg: AYBFou0RG11mjfBIHvIcvy6MC3u34SrQHKOX1X3A7T1YAiyiukSx0FYqiSeO8QI0aIW
 BedLfHttH1pzKFoKVh8xSVowQPJpD/b9KvIIQ2iwgiu3iaAa9iCojmhbYmkASe1cTRF5Ss/QSaJ
 ewdVwaz803C03hSXuNvd499oxvchO5bVSeFhokbVnOK2o2npTRkYmWxKlVLz0J4ZkbzuG41N9gr
 xsqWKRC4TG7Re4bTYj+ogFeA6F6Edm5W4UmGJ+2Se/ZyZrjFsFu48xzABNgJMdmDvyUnfgeIkuh
 jKkSNO5bz/UTc5XVRDaIM4VJTSFXAwKt+J1XCDU2YynBqpNJaiR3ALGHALdh8uw++ZOLdyuJUHb
 BTXN+drAlcX6PNVsIiZUjj3s/Esz7ggFBOYNHkuB9VrlgPbWhPhlSwWe3Ts2KP/V7Xlmg7eDAeL
 3T4jXVI8gwIyUGGFSuouGexuSI/sTZn2uBxFq/EuSa2LP5H0apmEBlqWRhyXHG/MedOb9vMTttr
 MwFFHExb0oSaHA9A2nrQAa4OiaU/3yl44sOPlsOO+oknTUfVyw4I48RX6v7ulFl8WPgfg4MiaT/
 f5geMAWwuJY0I+dm/xZVnw0w0qBcKHWoP9pTmasqmsinh3GdYTyj4qO78iBI+3k6Iq+bSno=
X-Received: by 2002:a05:600c:4f82:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4ac1889c857mr215222075e9.20.1793626845007; 
 Mon, 02 Nov 2026 05:40:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:44 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ishu Brar <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261026-panel-ams644vk04-v2-0-e88cafb3e577@brar.si>
References: <20261026-panel-ams644vk04-v2-0-e88cafb3e577@brar.si>
Subject: Re: (subset) [PATCH v2 0/2] drm/panel: Add Samsung AMS644VK04
 panel
Message-Id: <179362684370.3310106.4332858082729247133.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:43 +0100
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

On Mon, 26 Oct 2026 22:09:31 +0530, Ishu Brar wrote:
> Add a binding and a driver for the Samsung AMS644VK04, a 6.44 inch
> 1080x2400 MIPI DSI command mode AMOLED panel with DSC, used in the
> OnePlus Nord (SM7250).
> 
> The driver describes only the 90 Hz mode for now; the panel also does
> 60 Hz, which needs a way to pick the mode from the display pipeline that
> I did not want to invent here.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Samsung AMS644VK04
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/362fc4c73d39eff00ff1232275631a5b05474a52
[2/2] drm/panel: Add Samsung AMS644VK04 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a72e7d5b3d038915e05a1c459b513e40f7e06ec2

-- 
Neil

