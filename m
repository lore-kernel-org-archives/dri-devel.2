Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E262CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3FE10F806;
	Fri,  2 Oct 2026 09:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rsnBWrqD";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2CC10F806
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:24 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b0591cf85so1213145f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932583; x=1791537383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RbUJ70a7/T0AAXTkHVeKzaKU/0/JyXpkSVeKdxVFGPw=;
 b=rsnBWrqDhmE0a31ckQ8Nzm9f26GTYRsEHqK2qPCGtvZV6OKxH5mLFOQtWQ9HBiR9N8
 di8T3zL5CMQuzXBfizgewj8dRA0ide4v6jjV0A3Z/CYF70OtwpAdQQ3a99a2l9PCrerD
 hsKlHTQ1EPTCmjmy6+qtm3693EuTfVEp2wGrUq3NGNa27bTHWhsmRl504Si//4OXBU7M
 O+itjqUL+RFOhspWe0DIWudGt9qfvmi+Dfp8sWrsRDc1bKLiGwYTMVXr+GFyIk1KpQIi
 8E1UKgSwZYgzjV+tSeqYuN/mQkbrA1Mat6iQGbdshRZtb71BeAEZaO89gW4LrUAP2t+r
 iNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932583; x=1791537383;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RbUJ70a7/T0AAXTkHVeKzaKU/0/JyXpkSVeKdxVFGPw=;
 b=D5WaGoJggFRSy3rvRjX2kBZdldv6yeOVaR56rPm3oxHOP5VVr2duHPFGSDtVVjbMHG
 Z/Qvnv3FpCQuEZ+ArtpZsOv2hIpWslDWREflyB9JHvjDziMWqmD8xvT1jzgnSC6HnyEx
 l5rxgPcqVCGEYn3gKVJLrzo8zn6OO5FB/55iR1ufLUuJr7HJrcgg1Z45zLvxfwt9FZX8
 oHlcxiuYB+Ktc/Ulnoo5M2713lz7j2VFneIqb0AG5BBQ+rSuh5iZfdvF5NdfmyPBmbbp
 SJpCOkGXzvPIxIT1VY5w+0Ubt9vs/2nTTSkta74ax0jyuiLUB1N249y3GIhrpGF9C31c
 1cMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOlsAggLXPy22SYigM8SwxiQy2s5YAM8NL0stsJ9rzim56ID39l5cZ3BzetcMJPZh1oqAlISausUY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIA9vgLyFcqGjtM5Gm5o6Lfu4AcVgloSwea/8lFZDJlqLzOVOId
 QzQCnz4EMxG7LXZD/cDG4tzCg69beNBVeeuHANoke2WG3lyNIto3wfzYwDT/xL44HyU=
X-Gm-Gg: AYBFou1MnbuBicDxbhMme18xsq5bMsePivH/6VQW97g5qwQ5AL9RZjYrS5PP/+cffyx
 jgnlb0b7YVP/9pDXTEx5wlo9f1tES2NLAnrhFdSfGNvlGf/Y8y7UE9tcqwOftTLfPO/OMdOE+HG
 eSEt6r11Hg8DY97Dqj5pV0gSG/qo8nReHK2Xaz/sPtJb/MkSEmbLTJ+f/xaFy2910dUUe+0FaJW
 Ym0P6SrTtDRUrmsJRLdjxbvmj6MOoq1s6Cmcj+8HJDLgRSQzRHmHqTZ8hqoLgUULAFWwODs46WE
 pxG8GGEuXvkmb/LB4AKJqmCRULUtYt9prvNWXv+m18de/OGG6BqycZHZYCsaexOpJMhPCoBGui0
 BcbKRV5qN6TOma2sDhaVn9GodTmtPvP0EPmxFsyvRmAkmg+G4ewI9LPdETbe2wZIdvScFSRBT3b
 rsB4XzBBilf0yfUf9Z1w3EGZJNW8gV4mhqfupmZYLnIFDiEFg5gKmZMxuj0tt4Rmg+bm1ZiR38Y
 ryfn3WuKPuPhqB0KCMreOp0kjLWdA==
X-Received: by 2002:a05:6000:2285:b0:487:197a:5c1f with SMTP id
 ffacd0b85a97d-48b1272b524mr4209416f8f.49.1790932582851; 
 Fri, 02 Oct 2026 02:16:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@nabladev.com>, stable@vger.kernel.org
In-Reply-To: <20260909201346.937343-1-festevam@gmail.com>
References: <20260909201346.937343-1-festevam@gmail.com>
Subject: Re: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable
 delay
Message-Id: <179093258210.2282096.13923382036557231233.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:22 +0200
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

On Wed, 09 Sep 2026 17:13:46 -0300, Fabio Estevam wrote:
> The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
> between display signal output and backlight power-on.
> 
> Without this delay, the backlight can expose unsettled panel contents
> during display startup, resulting in a brief bright flash.
> 
> Set the panel enable delay to the datasheet-specified minimum.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a92ed345422cd66329b5e9d4e82b0452e185f36f

-- 
Neil

