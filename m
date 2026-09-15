Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3944CC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892B710E254;
	Tue, 15 Sep 2026 06:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDbw7Kpg";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B94210E254
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:43:08 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86dd69a1b15so691647b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789454588; x=1790059388;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKUg9BLWff5kiPeotNdE9F6L4UtNLkRCJ8RzVJJbCgI=;
 b=VDbw7KpgtCnKhq64mumcagbPU28DBqmR1Z22euv606jOyn93YNXqRsbkCXbF1KZHUK
 P5CwIt7bDOefL0XTNUrM1nmNicW7aBrfB/DbQWXfBclLa9fQ5spOK1yWQ8f5SDsYC0NV
 Kwuv080eocO10oD/W38Vc7jt23dzso1b1qMZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789454588; x=1790059388;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tKUg9BLWff5kiPeotNdE9F6L4UtNLkRCJ8RzVJJbCgI=;
 b=Pw2w68gtrd2PNnT/0ZwRToAgRLmCXFtFsM5/cSw8NOG0p6bezMTRWFaLkFIekIKD3C
 1BxwBnkhP/5Zl6b0Bo9pQse+b1KwY+EVuzAqF1ryXK9Edv/t8ZKOCJbg76T+O8OT7avE
 1tMwinh9pnLW3Tleb4QfiLgf3MF5LIHkNTtJuNALAnf7Bgr3We/l1u9lYqVoJ7Ad6L9l
 Lj5JHiaXy8zjoT/tD3MVCvJ8cAn04lOTYJjjik0dEmEUOiGXYC+RbN0Uoi/txwx20/vq
 MCuhMBzArr1oCTL/LKWJJ4MGcAMcYCtOTPVp68ZYDam5MJ59wcwaGn0am8M12ln2Z5TS
 pXFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz65Jku0kbUntBp2xC1IyOA4CiQBcE+WY2yhy6mRNA2xv34n5AAx8Iw0cJ50dLTYloNAe3a4Ueb1HQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ldgJnVQQGZP4awxkaq/J3zOKAw9ZbjG3QH4SUSb0+/JY5eTF2u
 F9EB8pVydBbxlgo4emC7BkrsdsBp7LhdnHseQL4/ZInCskcCRypzH8MURxyD8+zcow==
X-Gm-Gg: AYBFou3StY0jc1qJlnNWUrmMjPXHl6+rHvIBki+ClhUMLQanYRoYO3JQAgUiGcHO6KE
 KQOK7e/rpgB/9YIvEqUU2sPEPTr31hC7VgwJvopyTaz7MvbyAMlUmqRU6dE5c+hp4OHXKKAqiI6
 M+P91f4yOm+6ECRrzmlOjoCFyve5/Nq1Ql+toWjpAPyJ7fc5E+3r/RZG19MSRzJvbkzrrJhNQMe
 e8WR0Wglc4iXP0RgF3imD8UwJsrul7lanv+Okry1obkQA0K10pjW5SQ1gkMYRnJn3KnHWQ5N3Ab
 4dEVt9d03FRP4bNmmsP6wVyQ1sjpR1JFDRDJ79AkP8t6NOTA8SYy+4N/sLKJEEhMsOuy88XEuqo
 HXWLqTt2pjcK7QQ+Vpx25SBtHWrHe08+mdXZm2MI05ji+aBDAobvhkeeKGWNJvAS8Wqula+pDKW
 im0c9u2Tt/+PyrZMiZxmsbSvzfta8AjB/4eo/b/Hs05aMCxSuH1wskAo4jvmmYFfhGo2PGTz4YR
 +ZjmYG2WPadg5Jf09cZSY5eSy8njz58UQTBWMc0PqkIhjY0N7/4NlV/rQ==
X-Received: by 2002:a05:6a00:3996:b0:867:bb96:52b2 with SMTP id
 d2e1a72fcca58-8708abcaaa7mr3435307b3a.5.1789454587912; 
 Mon, 14 Sep 2026 23:43:07 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:fb1f:30c0:2c68:79bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b29cbb760sm5618262b3a.46.2026.09.14.23.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:43:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260903084823.4156065-1-wenst@chromium.org>
References: <20260903084823.4156065-1-wenst@chromium.org>
Subject: Re: [PATCH v2] drm/sysfb: Use iosys_map_memset() to clear buffer
Message-Id: <178945458608.1777136.8682538603402448473.b4-ty@chromium.org>
Date: Tue, 15 Sep 2026 14:43:06 +0800
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

On Thu, 03 Sep 2026 16:48:22 +0800, Chen-Yu Tsai wrote:
> The atomic disable in drm/sysfb currently clears the buffer using
> memset_io(). Since the mapping is provided in a |struct iosys_map|,
> it is better to use the related API instead of extracting the vaddr.
> This is mentioned as a TODO item.
> 
> Switch to iosys_map_memset(), which takes the mapping as well as an
> offset into the mapping.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sysfb: Use iosys_map_memset() to clear buffer
      commit: b57c9b345d18d67902625355c45caf322e2ab794

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

