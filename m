Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA3606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjw2f40i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5223910E0CD;
	Sun, 15 Nov 2026 05:36:36 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C720210E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 05:36:30 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3704d30b84fso2891379eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 21:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794720990; x=1795325790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6VoeGe/wk8xgZpQhEIYsSv2epjnw3INGgRJlWQrTDE=;
 b=Sjw2f40iIvGDDKoTBLzb7cOBRr/VRaqGU7qJaDj5WECIg8j0F2jKrlpohjLuE6U1uh
 j40lN13IdG074T3f/VFeqkVukbDbHooiRFNFFmVhRp4DVjIRt8rw0r3ZaxAZNl5t/GMA
 CufltOLETiLGG4pOz4SXbDcMGIud18gLAVVO84o1wFjqUiDpCKGgHVnbUMGedcXk1fD3
 W+nrPVk3tnlm/CIMnfi04x+n4vRY4nTGuhLNYmfNJxL1cSMqCP4g6ZufujA8wmOk8W69
 SixFPJk9soT4PbFEY9nXUgeDP/QsHUKzgG75ikcyUT6gTfzkfVa1PiHbP/veo5FsyvYx
 JTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794720990; x=1795325790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j6VoeGe/wk8xgZpQhEIYsSv2epjnw3INGgRJlWQrTDE=;
 b=gRECq81aFecaPcOuXTcUEY49WXuYLzLewGt0SbyfVTQYffcqsJ1LkRObXoboHb7vAi
 w6fjWFcREZluthBlLy29/qC5/GjcNATZ2dJCWO8giWery3pizHiLmFVqMQOgv4QuZh2d
 6kNHgygeTTxSYZClmsRzNG1X6vBr2yO+IAQhbK/9L/F+StnQFpXgnj5NpQ7j+TrtmmQh
 PT+9M8d7R/SbFfIu9jq0mZN9GuUNIWgEUC4f6dUpkIDNbOrfSH1nJZri23YKtCYg8ebt
 ERPm8c8Ye/4slE8RcDXgUOXokoPqFa37cY03uoicWMc80pw5w3y6ZC2APSZhuaznStD1
 L/4A==
X-Gm-Message-State: APuU4Z+//llGeK9uG4OINbaWqCncVN/OAkIZNnmgqI19kE3LLZrMce4k
 O7nfjIKRgn6HFV4vTSRKHBUzAiU0skU536hEoUnTNXxO2+LENUNQtnDm
X-Gm-Gg: AYBFou0sk83F08mC6PYBf0uEkCV5tXg1otbf5pW2traVpq1SrrwPpNpptaFX5UQIXSS
 4k3QDdwdl2+/V2C59eEjAeBDUJ/sZDcyPB3yhTnrixr237gkIVkMO8hY14ZytTHhiMSltrVR5am
 NPrqLifcJj1n2TARWM9YOHg1O+ta6DBX+gTOAa6p55botInE1z0zshLl4V8T4/Slox4J2Y5aOL4
 QT7tr+zvmQ6xs+bKerjxhTXq6QTpJ+tnPx4/nM2Fz02Hg16phbNTadYZ8XC63ZMTrEm4D8zo5sN
 qQhaaYsiLG9XWMv2f2z1djwehYXaaY7ZTy+NSPR7GchESopdqzKjXPQp22hGLM2QvN0lAjpSvjM
 yMWWS3V3urjkTEk1JSJpMbkq2qNexfCgAXABcicn5eODpyEo0n/+D1Y4dyWBnui+K4hsCk2Xbii
 x0vFFJ8QxQOjZYsheQ3cQBmXVCvDb0V1YlYr1JExtZcQRJRmPPTfTxsYorB1hf0twA+ku/4wWpU
 v5rnq4RY0qYh4vdiwKk3wg8o9MO6GqEyu45rl1K+kvyemXS+FVZkfki5xkKf5uU8CehGIE6Kv97
 sKq0pGDxpurSJiUORyQY6LRrVDZh2fPzsk1nXJcJuqDvPkTpsNvgCNXJ8gyx
X-Received: by 2002:a05:693c:8813:20b0:376:77e6:a66 with SMTP id
 5a478bee46e88-37967315a29mr6673278eec.16.1794720989851; 
 Sat, 14 Nov 2026 21:36:29 -0800 (PST)
Received: from arch.localdomain ([152.175.35.65])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm34739887eec.8.2026.11.14.21.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:36:29 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: sashiko-bot@kernel.org
Cc: dri-devel@lists.freedesktop.org, jerrysteve1101@gmail.com,
 sashiko-reviews@lists.linux.dev, damon.ding@rock-chips.com
Subject: Re: [PATCH v4] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
Date: Sun, 15 Nov 2026 13:36:25 +0800
Message-ID: <20261115053625.404795-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-215231@kernel.org>
References: <sashiko-outbox-215231@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/bridge: analogix_dp: inaccurate RK3288 PHY comment in
>   analogix_dp_probe()

> [Severity: Low]
> Are this comment and the commit message accurate about RK3288?
>
> In arch/arm/boot/dts/rockchip/rk3288.dtsi and
> Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml,
> the RK3288 eDP node defines phys = <&edp_phy> and phy-names = "dp" for its
> rockchip,rk3288-dp-phy device, which drivers/phy/rockchip/phy-rockchip-dp.c
> programs via GRF_SOC_CON12 when phy_power_on() and phy_power_off() are
> called on dp->phy.

This is indeed inaccurate. Good catch. I will remove it in v5.

Do you have any opinions on this issue, Damon?

> RK3399 and RK3568 are the variants that omit the phys property and configure
> the built-in PHY directly through the controller MMIO registers rather than
> through a separate PHY device or GRF.

Yes, you're right. RK3399 doesn't configure PHY through GRF; MMIO registers
are the correct way. (RK3568 eDP is not supported in mainline yet.)

I'll send a v5 with the comment removed and the commit message reworded.

Thanks,
Jun
