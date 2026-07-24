Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970ACC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1E110F323;
	Fri, 24 Jul 2026 08:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OgcVk3NY";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5315B10F323
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:01:47 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so6241655e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784880106; x=1785484906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rAfX3k5wj/8KZVt25ucKMpfpE6MXGKKgl1Anbl2kKTI=;
 b=OgcVk3NYoQ2HGJhau0l4yqVadlQwJAb1eYSfyzzxXB/H2UjrVc1OTuvvHt6Z/1P7FI
 vscJr2g0fxvdfRk+pIAEDNynO+1CQaiFlmBlJDvIZcRy9Anp+KcB1YSFK857vyJ3qTZK
 HBKFQNEyKbFoCJXKUF5kjnq1TrpSXd8fEJyJPXXheHKFYVTW9IXuZMiD7bwllvJpFlsa
 0qFs7I3KpvWivCFqsFLBFCzr1dwK7pN1Ydi+8T4/xCf9vlfQIWKM214mpciBruRWLIcJ
 cSiFVESgNnLEjXrXrAYPF4/Pp8Sm42e7MfjdZDEU/lsLtYwqxDabvfo3s06Ynyh3VGOd
 koUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784880106; x=1785484906;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAfX3k5wj/8KZVt25ucKMpfpE6MXGKKgl1Anbl2kKTI=;
 b=WhG/gyyGv+m7+z5W/rkyQ/mIJsliScCPatOBMGvcT40y3lZXMzV/MARvR6t6DwAH+f
 qoSebnNopl8TjmzhXOllsE5tEdEM8oR3uMo/8opgXYxOWw5bcdlKbWEN67ZXOQQUS7nt
 YVU4At2YRm5vuwX2k0yGrhY5IvJMsQ6WHmEYN7ZYcoFVucetVAVVgi7HLb/fI/2qC7tD
 /ofzlHNb/QhLwtJnMFyMsAVefPdBAUqLR+nQSaNK8UmOzfEU5bcrbP1Lp305PIUKkR/b
 Rf5dCLGgk6qm5d0r0JukTs0GgrN+aanj2L6qwA4v2my594jBhnaWScfQj1irJcYAAzO9
 f4zQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2FrWx8Sd9+fdjLZe2DOfouFeg6krxIDPfRPmMnU66bF4NL2fYgqSQ43cGxfW1CYTE64itmym7u/M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzHd3v4AWfajNX9bTFqkKezsBObMP+o9+skSYR2YFcU1R19/Kp
 MXdTP01zvKTIOoheMvxX/ZrgkYpONRuQ7NuDxqTjA5KLsHW9vFCHD7DyS8WiH1YaccA=
X-Gm-Gg: AR+sD10MnY3dlqpjkAGK1MgtkEOk6t6ZG9NPXnFGQqaQlVP4LQa84fe5WH1w50OMk+f
 oFSCldNyGfmkETv4tEuQgExP0hDypcH0r8sFu5N3XTQeQkIk8w/tq29LrSb0uiTRbnfi9ARf6JM
 XsfFcXa1xkwuA/n9J80OamzoroSkLsYdHmouCOhGHDNr2+i/zgFlSYFwdPSzS5bA6l2S2uGd4Sj
 W572Ocb61QmDr3RlfNR6Se8LMf58oSJ3f0n8h2rJ/u2QjFH8P2uJU0iEF0g/N0CbqfWGelEfqRO
 cfglFMZgCs/6uK5puGieeYySWiE6hmJyDQxqBIcGKLoA5iTPITRQCv6A7UoYzsZNeyY7a9o0fps
 eEy9zc1mAlSk8IhwLsDMJI1ruRh4DCSCzXNqZb5YgHA0SzX0wEHcFaYbw9YjosS09GryiBAoatk
 qVK19++wliKuS82RwLGbc5wWQ=
X-Received: by 2002:a05:600c:26d3:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-49574593d20mr42472695e9.7.1784880105557; 
 Fri, 24 Jul 2026 01:01:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d4d7sm54404835e9.2.2026.07.24.01.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:01:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: laurent.pinchart@ideasonboard.com, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com, 
 sam@ravnborg.org, Leonardo Costa <leoreis.costa@gmail.com>
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
Subject: Re: (subset) [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add
 Toradex Capacitive Touch Display 10.1" LVDS
Message-Id: <178488010464.449291.8023888105582692289.b4-ty@b4>
Date: Fri, 24 Jul 2026 10:01:44 +0200
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

On Tue, 23 Jun 2026 16:57:36 -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> This series adds device tree overlays for Toradex Capacitive
> Touch Display 10.1" LVDS V2 on Verdin AM62.
> 
> The display addition covers two interface types:
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] dt-bindings: vendor-prefixes: Add Opto Logic
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4685230d8288a99f1c664768b6eb2bd1545524c7

-- 
Neil

