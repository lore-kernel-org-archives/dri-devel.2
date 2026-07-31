Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7713FC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB53A10E1F9;
	Fri, 31 Jul 2026 12:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="cQJOznIA";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464C010E1F9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785501803; x=1786106603; i=deller@gmx.de;
 bh=S8g3/1oY9YczeNuRH1/sjOi6A1yDMSFibS2nQnYNERU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cQJOznIAfWhvsLAljZui1oIjS/c7fm5zCpc1uUVSW4DMuURdsUmZ2PpS8CfgBiE5
 U05Q94m0wAEIGQnE5LC3IymXSLdR4fqv0mQxgmiN9vFYC9eZO5OYnw7T1TseakPl8
 5uHrftpOe5Z6YDbDgoynNP0L0ZxsWncQr50ylkh7p4ngMrJGn8mlQvFenw9rXt3vY
 jA3teJLX9nke5ufTaW9/+iRPH4cax5my+33yKM0gddKeATZ+SqmkgEvIeR93ym76X
 9eL+GURwCU/yAy8fuw342ZoZCuXe8CbenReSkCEhz7fK+2F5jqsGd4xWdZQQ+fAQf
 GB357Sbs7vop3gzgBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1xTVBi376P-00oxvY; Fri, 31
 Jul 2026 14:43:23 +0200
Message-ID: <580fd486-ec67-4db3-8235-e835f0c40eab@gmx.de>
Date: Fri, 31 Jul 2026 14:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: add support for Sino Wealth SH1107
 controller
To: Jakub Turek <jakub.turek@elsta.tech>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
 <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9PfcIixWq08u1vVVI/4kluavRxebcXpoXDl7arytL6LCr08eFiP
 b78cepSCkfK+ZSvyNd2pPCxQJ0nnaZnOljsJ5aOvwV2Q2vLgljMtta4PH9k4J2bD5XsVvi4
 MyJIJ81uYPqYLcgrbj7v37jeOZ4v/ghgWbEDSietywo1ayutBMOHXY79+QGJ3riaH+Duu0L
 bgUwENjrOXqWz8kjGx0kQ==
UI-OutboundReport: notjunk:1;M01:P0:Lx/PPNpEm60=;GMhrhohgrwOOe4SdXCaFKZKUK48
 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
 FvAjCEDZ1LUIVOmUK2/29QDZJo75BYsOgA==
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

On 7/31/26 12:46, Jakub Turek wrote:
> The SH1107 display controller is very similar to SSD1307 but the main
> difference is that SH1107 has different memory layout and uses page mode
> adressation only.
>=20
> The SH1107 relies primarily on vertical page addressing mode where the
> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
> the horizontal/tile addressing modes natively utilized by the
> SSD1306/SSD1307.
>=20
> Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
> ---
>   drivers/video/fbdev/ssd1307fb.c | 234 ++++++++++++++++++++++++++------=
=2D-------
>   1 file changed, 155 insertions(+), 79 deletions(-)

This patch has many unnecessary white space cleanups.

Please split it up in at least two patches: One with real code additions a=
nd fixes,
the other (if you like) a patch to clean up indenting and such.

Helge
