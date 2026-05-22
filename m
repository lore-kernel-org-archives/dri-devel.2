Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4219CD5BB7
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2975F10F644;
	Fri, 22 May 2026 14:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="swKXL266";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6612710F53F
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:13:34 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c8026aa4d53so5367208a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779444814; x=1780049614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oxv8UL85VpOX5p+L7n6lxvKWMwkHziHJ65pdN0X0XU=;
 b=swKXL266Y109dGks8LC+bSo5vRNx6QJ/erhV+DMCHiCPVtM26gO7i4ZxspCsPtWpOr
 rexKZHpD8h1mUQ5uPiLwFEUGvOju7xJ7299YZNO2CAK6ebqFiISepfBz+kwRr3cOSSb/
 y+HkvTWl+TexMvIq74uen35DRZq4fDrs8mrWbj8YdiIjflRn45L1oyL1FKLbnidfkGis
 KNVGd+4nFEQjJbznun7v1eiyoBtAma8V0dmtUg9NfGrjXG++aQUmWzE3eqi9tIBUHKud
 OEIGf9AfVL59I76hfrfrv4kb/QF+ZdtPYZxQfGN9vULCbENTfDNZY1j0R6iK0BbGnb6g
 9+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444814; x=1780049614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oxv8UL85VpOX5p+L7n6lxvKWMwkHziHJ65pdN0X0XU=;
 b=KwSaR+qzHZ7JPDBZZ1HT9xoOfwNHwv9faY4DFhMT+iWffIm5KoQH8sbmV9Tu5GMc4g
 j5YNzQn2AVobBoam2Gx9VnKPhpFxbykSvDNG/TDxgPdaAHkwGlNzWsOLAIwTpSveQy1D
 lO0rCeXDO7cumH3i0C1eWvP1pNKYZeJirXhPebQX30P4V1314tTetOluX5yKz8BFC6Qo
 yJ/mlhYPD7+1o1ol6sRP68lfWmeWB8cdc5S/lncawcJFMj5agu1iEpJGietsNnvFV00b
 L+4Lk5eLaeEl+rCuunGxpuKxNXFl2LBTRITmLshaOP6wXLEym93cIle6pmhiJ6n5iU4x
 n8Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RQzKHXBQ1iR1gYWKOtTgiGCO8JmtX82vcD7mfQ2uhInPhoQE36x0PTTCHgAR3F4b2O6ER4TJ3XKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+GEYuMfqb5viAnq+HsEQT87UMUrXVG4TyDdpCMobW8x1PiWCk
 N0UAHI9ldbrr+neYkTACqI8gSXkJvW3UZJNeDljUG9y83Pp6M+JxfxRH
X-Gm-Gg: Acq92OH/NLxZEz40W3nLlsWWnrvHPzDRgQ4DMf7S7pGhTqshknSbO4+J1by5CcuwNP0
 catsiw//RPKMibcN3ds88ujyw164dR6NXTUsbNSFqZNkmdj3wNEPxsFaXyVCqu5iEpFPd71jTr6
 UDrvp+4+CyEko1B/odeQN1chvE9SEZ2aslT+wi9xQJ0/fFYem7lOzgRk5TLj8kiakxNKyQa27z8
 Xm6HhrOwBP/8pCBHNWQIv1iA7GFU+N9ZXAyC0VqkacqKEDewYUlN+d4JZulSz22shcpH2wOgzV0
 +CjXmJyb5hBX9GBK6ygnIQ/Is0QMCmj+sqVot6pwjuWknkXX63Nwa46RC0fGUL2/qqIWX5gWQyc
 Uf66T184LFA02wctWrOU9leR5VSX1F0NAdwWhLAYyoMnpxwK/lMWPayYFwTJC4uYvN6DySmILaf
 1CiKBMhrp/OI6q3U/xb9jlz5aDPbrd/4Wgo2V5meOlXCamHBR73U2FoAcU1MSOymx+uA==
X-Received: by 2002:a05:6300:2109:b0:3b3:21f7:15db with SMTP id
 adf61e73a8af0-3b328f704bcmr3288808637.43.1779444813768; 
 Fri, 22 May 2026 03:13:33 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852054d788sm1047586a12.21.2026.05.22.03.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:13:33 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] arm64: qcom: Enable additional hardware on Radxa
 Dragon Q6A
Date: Fri, 22 May 2026 22:13:23 +1200
Message-ID: <20260522101323.31911-1-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522060645.4399-1-graham.oconnor@gmail.com>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

Thank you to Konrad, Neil, and others for the very prompt and helpful reviews.

Based on the feedback received, I think it best to withdraw this series to
address the issues raised, most notobly:

1. The DP_TRAIN_LEVEL_MAX change (patch 3) is too broad - it affects all
   devices using the Qualcomm MSM DP driver rather than being specific to
   the RA620 bridge. A proper fix should be implemented at the bridge
   level. This is going to take more investigation.

2. The display DT nodes (patch 5) should use the radxa,ra620 compatible
   string per the existing Radxa upstream series from Xilin Wu, and the
   lane ordering needs correcting.

3. The rpmh-rsc early return (patch 1) needs further review regarding
   the implications of returning before full driver initialization.

4. DTS patch label dependency issue (sorry) 

I'll integrate with the Radxa upstream effort, re-evaluate the other areas
and resubmit corrected patches addressing these concerns at a later date.

Thanks for the feedback.

Cheers

Graham
