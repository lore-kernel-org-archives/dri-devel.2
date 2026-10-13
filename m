Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F875CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7240F10E828;
	Tue, 13 Oct 2026 13:00:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4268110E828
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:00:20 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d8f2ed7bdcso3833045ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791896420; x=1792501220; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BPjCWxUSfRvlJUtSVwuDIbCnah44rNQ2fIrGmDlzw+k=;
 b=K2U2Bpn9/02YescAKbK4RHOn5l4FYlYMN9UKJt3UT87a/TqbK3aWhb9jGyPEpFo3Zi
 zBMtGlye4RJxRBPtX2G9CNUtQnIQQlfl4EfGsMpNKmoBG3ihkMZEalzn0xm/w6Ki2rAh
 DTcL/hoN11yFKUi902NwoDNukDkyNe2pY7B+bFKGuQ3RB9VNwuoZr6h3GW3MEZHHJcLK
 kowDBCloi6KSomFLe5upJ54nBcHxrtSi3xrGlSepFAtuhWFhRWJaJWfKi8qHNd6wORbM
 WEibYABzpX6TCtlvyhjHGgmhx8j5vjBoH3NPbotMtXudnjwqHuqE5D6fks75gXGY8dYW
 iQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896420; x=1792501220;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BPjCWxUSfRvlJUtSVwuDIbCnah44rNQ2fIrGmDlzw+k=;
 b=UvhJ724SePUlPNNiwMBcIWqOSt0ZlbXjRNLucBot5sGsXQt34fiY1IO91DYMZoBLa5
 QzMcUFx1jpP3S/0nE4cuQTfozGxpgX2ec8CwczY0G7xsJ5QPfo3+0UZRz2DEQ+GYTXo2
 ghqEN9nL1uLbmjk+hB581K8UETWg08YA4T3tW40E4MNwE5l09hglB0JoyzNAvuUEUJsl
 B5Ws0zeo0CNgmpWg4h80ZP8l7adRVn0OFTPcZIFy7pR+Iv+5s26cjCwRc6GgFNnfyteW
 pUi1C+4UTQXLxjIoUwqznfn8Gjp6Siu6tk2wwlMyb9SrYB5jBQaxW2jp4YaWcibLqItA
 eDNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1ftwXxjwGh9TY/dpImYIKGhGwUAUNbWs1umAzQhQtuAIA1NaeLZEEr2GdIZrM9NVxSy80dI6fg1U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLnF/yzmqxU4e2CuqSPHg3Jo6tuBtXK7I2X3y5L/vz8EmASmG+W
 khZNRM+fVV8B762HJxst4dccxoWZidfyaeeH/inJ/rnJw5p7E+IBIdOQ1JHh31r8KK+HWg==
X-Gm-Gg: AYBFou2zPCGZ8jKZrlp0ltT180pHLvUXuBLltJz07jMf1fB0HWyaF9aWNtpgB6ynkz+
 7cGc5BOBEHJDXsjpFQJ8yrCgwzLzgGouDx3wUDeqitR8Sd2ZvbZh1DCGe2TLfDOm8N9DwNcFiNL
 LWfJy1TFjnlRHTe2P+PS2QpgWmJo1DBoeqUDY/YVjuH4V0TYi3EVWlW7GrAGHoLXBqJyMjg3cKE
 SXQof+Q1Y4oTSRN8OtzXn6JQBWlOoclqbJvVMO/ri1lC+mzu3MLluiF8XAhSaffEdwdk/iyaZwL
 Zws1/Zfa3iiLH54kd8ljdnW+mca9IiNJd6OhHXjYgWiAwCj30yU7Hp3DLaEjEiufwvybgKZVvMv
 ol2UJHSjMzJcwbxjws+YVPVM9p4989vCXw3ARzPqmjp4KIgY2+K1ILh9KiLta2Ro748J/lW6vwo
 u2OOTkO0UVhrrb1Zwnk9OMVf6S6s+vSggsCykw9K8KFMqdijVd+tw+v9+op85zHSpTLuAHpA==
X-Received: by 2002:a17:903:2f8c:b0:2e5:c78a:5309 with SMTP id
 d9443c01a7336-2e842ab6bb0mr178440135ad.4.1791896419592; 
 Tue, 13 Oct 2026 06:00:19 -0700 (PDT)
Received: from marchy ([2405:3800:834:ced2:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e4cf3sm53869375ad.72.2026.10.13.06.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 06:00:18 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:00:15 +0800
From: Adam Azuddin <azuddinadam@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jesszhan0024@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, andersson@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Message-ID: <as4rX-xVWUPcczNp@marchy>
References: <20261012064518.3497285-1-azuddinadam@gmail.com>
 <20261012064518.3497285-2-azuddinadam@gmail.com>
 <20261013-artificial-splendid-goat-d078dc@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-artificial-splendid-goat-d078dc@quoll>
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

Hi Krzysztof,

On Tue, Oct 13, 2026 at 09:33:38AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Oct 12, 2026 at 02:45:04PM +0800, Adam Azuddin wrote:
> > The RA8875 is an SPI-connected TFT display controller by RAiO
> > Technology Inc. It supports display resolutions of up to 800x480.
> > 
> > Add YAML binding schema for the RA8875 controller, along with
> 
> So you ignored my feedback.

My mistake, I misunderstood your feedback regarding the redundant
binding text in the commit description.

I will fix the commit message and send v5.

Best regards,
Adam
