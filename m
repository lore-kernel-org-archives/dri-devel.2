Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AD9FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A0410EAC3;
	Tue,  5 May 2026 12:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OMRxoJNS";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959DA10EAC1
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:51:19 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso55561585e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985478; x=1778590278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jWGxGUhLVekFy6oP9f1SxxdmOz8UnRcgSNK3hlCv+8=;
 b=OMRxoJNSyaBAQmBlq56iOhsw2XqRoe79GBgYUSoxl3DLzspvjioc7eh0hFhrK/jKvl
 d/at0bIKL8676UIRzMbFHmULQVHnnI7x7Ohk8nUr3J7RG255EAaD3EZIJ/p7d3ejDA1g
 vD+PDOXajwOsXFKhaqQsMRNOBC2uvMlrDCcDQ3DnbwKWa/TDonva1HSMg44DmM1jqyEM
 zlUMXHP2jlQB2hCzmSRG41u6hfGsI0GUm0K4HWyjliow98AT4Xus1jKu26n+0nE8Ho2I
 II5ubPyvyHl316TQqMbLwmRLt/Cj8IgeBioxEAjztbDfWwP6otSk1aog9u4ooICifF4a
 c+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985478; x=1778590278;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5jWGxGUhLVekFy6oP9f1SxxdmOz8UnRcgSNK3hlCv+8=;
 b=sORzivxGI8ib/lPty3WWaoLRDqFMBi7NIbHzsMaJOkDV2N1zs5/B1Derx8zplRvnYA
 uVxsLK78rlrQevUAQAYgIxCZVSY/YxgBcn0ZZrAGmpme9fKwLuTHwixXdcE+62guvtOE
 6D540S3EtPCq109iITo2Ues3TjIWbx7TjxZCvvW/+jTP3lnf3AHxSSOpkCq/yFmAXyqG
 vHKrxvt+eQ+JHItmM4HLI+sO1GrY7FNkN2VGY5R5bJnlxKz4H+un9hvgTfL7TVJI1Vs3
 m0c7JZlVUszbuQOuBciBnDUOTF7HlfpWy04S62QXjh1QMi/ZfBNyfLxhq+EBlAQXWPdj
 Gniw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nG2Z/4xkPdCOrrgGzRr7HNvA8uq4J7ecBpJD6E7vgLddnXji2tNOpnycBJd0QRmlpUYLyKiQjceA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAJfXLlcnGZpvsZ3m0oTNaQqwEIDgiEV5SxD1YnloWRA40Hyxx
 7eIaqM5OVpuBDJx12ipJtwx0biv9ENmGUmTthHmLesI8J26YuqZ/a/sdYHG+v/bs17A=
X-Gm-Gg: AeBDiesC4lMcW5tmtDM5nIMzt5DR/lc7bjTY40FN106OfwxTcye8KmcdUKJc3WP54Fp
 AreQMcWQ1BodBlbtLrQuWS66oJsEqsi1sc8QpIg4lfq9sZ7Y5UD4mwmgU8F6U/bWAs6BEplpV5o
 qk/lIP4/g4cj0i3Y/3GNtp2SW/fNgwW+t6sDSv0JBwevX4HKXXIu4p99gmAwf6ILG3HmoX04CRx
 b+5o9f0v2y9jm7SZKODGS+Mrk0jCEi0mZZKLCXaOQpx5lSgnUcbiN+dCLSGUmdT/daA8Qq5Yq7j
 WA4wfAS7dTnXjTX4w5vIm71X93BiuFPRAuQ0rp5w2cG7lEcsy3KaBC+KbbtsqLtDISEDbS4fJo+
 6/41WtcMznlqvFPFMD8jqENGp9786fUEoAAiG8SY1Wdd7rDBN2pctrRVNpLVhEkxsmDv1799Gmb
 jmyq/Ri8B+f/QeWOZoFod2Uj/kRcZEbxgwbwwtMQ4q/vQTDDYXtaahORQ=
X-Received: by 2002:a05:600c:4a25:b0:489:1ff5:edda with SMTP id
 5b1f17b1804b1-48a9853c8fbmr138044935e9.6.1777985477980; 
 Tue, 05 May 2026 05:51:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:51:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Christian Van <cvan20191@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260425053948.117714-1-cvan20191@gmail.com>
References: <20260425053948.117714-1-cvan20191@gmail.com>
Subject: Re: [PATCH] drm/panel: feiyang-fy07024di26a30d: return display-on
 error
Message-Id: <177798547711.553197.13751437040191027729.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:17 +0200
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

On Sat, 25 Apr 2026 01:39:48 -0400, Christian Van wrote:
> mipi_dsi_dcs_set_display_on() returns an error code, but feiyang_enable()
> currently ignores it and always reports success.
> 
> Return the DCS command result so callers can observe enable failures.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: feiyang-fy07024di26a30d: return display-on error
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c67e8787f6743101c90c7a9c4bb7cf6f1f739f83

-- 
Neil

