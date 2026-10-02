Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A990CCA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C73F10F80D;
	Fri,  2 Oct 2026 09:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dI0BLIYN";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E547D10F80B
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:28 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afd5b1678so1528521f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932587; x=1791537387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5i4f7F+jr4QCAb/6TnLantwlo7EASL44G0akbRfkeFE=;
 b=dI0BLIYNyK/hO1eno1Fhify/++TbvxBJBzVF9j0XbpbNpH/Gyrpeub5DzGjGepycER
 7ek7v3UgnvyseX5AI6fcmCh0HYI5p0kv03qWYtYzUtdtbh0CYSCfRBG9OF3cdc/Jwu5H
 g3Uf2shTc51Pz72YwIsx/+mZrm+MYFrSvS8ldpG3md/QocZhHihuoYhcUsTrgLwz6yZa
 pegbbkF3X6TIU0ItCDv1AJVe5MIPmOmzVVM3Oklc9Bz6+CtWl/2svyt7Qli9wzmWRPOu
 Qp93yIg8nseTPvXPzVbD5vLHdQuK1sbF2WwPHTB4U2d/vP2ZldDFDfnTbECSIsMkPI2V
 wDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932587; x=1791537387;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5i4f7F+jr4QCAb/6TnLantwlo7EASL44G0akbRfkeFE=;
 b=26nM92RP79AGWqdkaLI0MpApfS/D+PK8JQZ73cnKW+dtHKw0OCxiLHTE+xK2oy/iTk
 suuSIT+wD2hDjR+k3KZL2BfbRRsA7SMd6UQjz8f5t8M5YARJINHfZx9Y5n6T65Nb17er
 fUS/TGZgmt7eCq4YhOPUe+PpXHo94JVXF38hKrx4O3nrMUVk9fakdi/SedyqwzxaasHM
 I8/+xc7UQg+FfgGNu6oDJ31oKlr28RS1rKRqp64aaEAjAfQ7bsBV/tn4PaPPfwS5goWx
 n+diWIaQHe6kEqwvMkLvSS4Tlm6ktjLp6vA7rXsiQ0OLGD0DSorU+o1RW1tiTaVbTEa+
 WkjA==
X-Gm-Message-State: AFq9FYLsxcrWPlq07SVxVwnSYmaAluMg7QHRt/Ocf/BYmQ6Vx2r34Ulo
 gZwW/QVYYwXXbJKyeYRBtrtUGlzVLm0q2gptw/o1ub9WAnZBrXLI2WWyQ6tYGB2dKsD6oeFcvYQ
 KIxS4
X-Gm-Gg: AYBFou1CgyqvTvbwcfBf23BJBcr3cQaoxmruVDVej/qqhq0W2SDw3uCw7NooYVnu5A1
 bPLlgt2Eb4nzfdE6u8F7uMg9kSoEq4we4gP8WhtfufBIMCDoRZnfPLkBZWGbAaZbdjxPP2aiZ86
 8wvWIbZuB9APE3ya3fnwDQ7dboATM2QR8z8qw5Mk/rxUf2FuAv+Z9PT5ylEIpwhvi3cwkjLx1fH
 HQTvW1docL8KlE6vpx+lLZd0NGaH6i7XpOEjiQMV1ewjhj2eaN9YdRtrqOAsSEryxHJcVmQkvfP
 a6i91E1Ejck3Tll8D87jD7Q95DHTCSAdCRmJkaKKqb6Nk/iCtKebbAKHf8mSrRgq9DPTegI1cjP
 IWkm2CLrshibgDfyFy/W+GapGDD+LjSri0SdQEZmK+/tgHRm7dvqBBu+FXp+rbzA02I32BAFMkV
 DRtXM/KnW/0eyteUIzNFCsciSC4kC5fF0knk+r6s8lEOnWWg2+pI3q28shp8QxYnO0nmvJKeAB+
 tzODYH/7fAmuyCRGgw=
X-Received: by 2002:a5d:64ca:0:b0:488:83f7:6352 with SMTP id
 ffacd0b85a97d-48b126f542emr3954542f8f.4.1790932587146; 
 Fri, 02 Oct 2026 02:16:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jesszhan0024@gmail.com, dianders@chromium.org, 
 Hsieh Hung-En <hungen3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
In-Reply-To: <20260929080143.559685-1-hungen3108@gmail.com>
References: <20260929080143.559685-1-hungen3108@gmail.com>
Subject: Re: [PATCH] drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi()
 functions
Message-Id: <179093258630.2282096.3657268335428090758.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:26 +0200
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

On Tue, 29 Sep 2026 16:01:43 +0800, Hsieh Hung-En wrote:
> Replace the deprecated mipi_dsi_dcs_exit_sleep_mode() and
> mipi_dsi_dcs_enter_sleep_mode() calls in the enable and disable callbacks
> with their _multi variants, as suggested in Documentation/gpu/todo.rst.
> 
> The callbacks retain the same return values. The new helpers additionally
> log an error if the command fails.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi() functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f5c3d702f4ccd1e953436c6a16e542e232a743ea

-- 
Neil

