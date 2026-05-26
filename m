Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE02ECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208E310E50A;
	Tue, 26 May 2026 14:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wv5bYiCV";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4CB10E50A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:39 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so7920000f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807218; x=1780412018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5Dr3zYrFSXyxUBIKW5jfQLWA8VBkTchLSTQFuRA3B0=;
 b=wv5bYiCV5zaysm0nuYNHVdJZr0aOPVrJsU1BYb7NAcdihM5IpdQQoLnf1w5OiF8B38
 F3t3ETqU/m93E05HJOL18CeX2BBdn+gdqA6NCaZmARbiPuAF789Qo12ICa9Q2Mf+7IIr
 cyQoAl1aQAH6hktkZRJHBhn7TCa1vyOTLb1bLK77LuHLqZE/r47DnJh+YpPdADvzqp7e
 ojB2vikGTfFM5Pa/yNr+HRdcxt6usvSUgnvKxNRpgZUhdvL1i1vrg+r0dhGh0y227zla
 160LfcQPKJzxxm6Ywu0VO8HQ/G6gR1eGg+6hGWgaHnt9gai/RycU99q4eyuAzRRX34JV
 kdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807218; x=1780412018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5Dr3zYrFSXyxUBIKW5jfQLWA8VBkTchLSTQFuRA3B0=;
 b=UkK3mdoFbBJiqFreXONTrIO2ld0UZl9fSS2uD9L9Y0rcyCcpsXPxP27i7a+MLmGEPI
 W3140ifmRmJtG+VOQcACEA6gdk+6NY+Reum8bnjLtmeKCGCv4GPaqdq8ci9xWjhEX9d3
 64Woc5reSwjrPdxW6wNaA/3CDCXjKNNmcW/SZri6qnBPmlNpQTPraSi4MsECcgJ0fqwK
 +G8Fbzxrr/oOb8+VkyZktmiOPxE7aAYWAo5rUByjGKmbpkB8A+rKT5G6Q9xnA6kEZoCF
 6W4DAsA1J3HARAFhY0TGHPG1DBcd68loQqLpmlh0SxPzuFv7k7X0aGG62b407hp6u+xT
 GtnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1yYucSSQkbHq/96VKhOCb1JFasfGAz+4wZVl+pPVqk8I+wR7M0DFtKyVhVZ4HPoHQHOLMzWxZD8w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH6D98kgLZytlDNjDmXUbzTkUkI3iLPMgV+jpTRQckdJz257DD
 qadRT2ZBq6TmojWJbHo5+godWtkfUhWG0BmTV5VhCuHpmqA4pr+3FN4gG8HdMACW3HQ=
X-Gm-Gg: Acq92OGnOv17UBlp5Bp4KVaoEkbmgXH8j4uKYzriMw8ECzSHya0SBz1tSVoNtD3V9uF
 ctHktp7dMIFnypkvFWFFz3GtVoshhU53KPHVuAPuWA9QIyakPcyeEkc3RHAVvO7TwAxnJ1E1IpY
 8DERISt2Ib6RBPkQOJJzq/V6zj3u1OHDY1EajfEtegdjsC+Fl6VVw7+iNgbFpfiOR88bxWqYBoD
 CFPtyA2xM45Ajxc21RlFgY/s2SuNj8JJSn/6A9wfs8HKqbZO3ZAfIxjHt/wka5wgiP8OioCjGRL
 4qo2x66p+2K31ORDlPu/R8uY84Pb3jNbnRztR61YIRQSZhM3As41Fq14kdvxlgAGnEep6rBgjC/
 UWH77fDCS6gYhMW/q4QOjcHrDKeRXippO9EatgQ0l1NdU4bPfMLX+fgdQjaw2rPPCsq629wUhXz
 bxHKyBNnnO40QlT7lq8PreXgGG4LkQ9riZliWecor7Wzy/
X-Received: by 2002:a05:6000:470b:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45eb38a6bcamr31101990f8f.37.1779807217972; 
 Tue, 26 May 2026 07:53:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm36278884f8f.24.2026.05.26.07.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
References: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add
 AM-1280800W8TZQW-T00H
Message-Id: <177980721706.3070642.9809257251059448282.b4-ty@b4>
Date: Tue, 26 May 2026 16:53:37 +0200
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

On Fri, 15 May 2026 10:22:00 +0200, Dario Binacchi wrote:
> Add dt-bindings for 10.1" TFT LCD module from Ampire Co. Ltd.
> as part of panel-simple.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add AM-1280800W8TZQW-T00H
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/adcea8fcedb67cbd2f8a164393526f26c36c3dbd
[2/2] drm/panel: simple: Add AM-1280800W8TZQW-T00H
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6acb810ebc5d8dea5c250326c14dc44e32dc8e92

-- 
Neil

