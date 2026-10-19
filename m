Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D261ACCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251CA10E51B;
	Mon, 19 Oct 2026 06:56:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB0010E51B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:55:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso17314815e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792392953; x=1792997753;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FZ2zwSutLzynNR3SPyrjH8fZEghMurXsmINrjU6TAss=;
 b=ZkyI9SCvpx7+GOIgpVSIkeQNni1BSTL9aAR+K2y6gB9VkZnZgK28HK2lgMnTFcPT7U
 6n6ysgb8vQPpR0j0ntSnPVlOAYlJwKbzwVQ44+lWY1MMoHVE+SSoCJS206mIdBSatZcH
 uCCjTV6GhgY6Tm+EnFDm28tt5aoxdX5niQbuiOcpNyNB/sjD+HdcJLBAGqi6RIf+8Sev
 e2es5OwD2asiHjY/JlPauE6FJogAamDSE8BEVN+3MLEpO1NY3IC23mfHFkiHY3xY23r4
 yxu1o3shIzgK/vld+oy/w/6JldAXKjDBjwd0i0pA0otILuhJ+GjfVH1P+vxJFWhws2qD
 TkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792392953; x=1792997753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FZ2zwSutLzynNR3SPyrjH8fZEghMurXsmINrjU6TAss=;
 b=vIpOjF7E0oBZln9s06larcJ1Gf6DHr5j4WgOlvXdFVvnintETU5/ZQyI5+dmOQdWWa
 S/sGhdQtfpzHB1RZZ7sDB+LU7L5nZgdfkqqhgSzMI5hC25exse5NSXFfOyTdfSGQ/SCn
 p6kSC2gEwWDTlE3FHEFUTuK4ILVBXhPKMXEDvF6/dDq0+Kv1jAqM4H8UpedSyKVAeugw
 poOMDLgPBZFIMgUL9Pl4uv++rHBH2tV+Ax0BjW7ScwbGhqFFu3ufiolpU4qJZVG57/iL
 L/Zipff1uY+vJ9AVtrvU+Uzw3aGXpqnPz/Mh22XlQE4MBqTY5AHjijgy9O81SJepr9z5
 ST+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXXI3ln2o+tdvpetO4O1Z7lguHBRrvqLcHPS8+gJVHGlL1yXYQkIKcm8mLoaZ9VbzuCYsytmjwNkk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAvofwhyfwyGrA8Rht4l9rMHggIMRBbP5A/BhsfbFOG56XKJj8
 7G4uUwhv6JA1W2uJYCGcHIjOHExq2vLCt7oE6tbfoACfyqYscba4EXKDvtJNR004Qsc=
X-Gm-Gg: AYBFou0+y7YGGEFJDt/PgyLqiFN1cEN2BxGkT/wfw1urFE9KHD/o7AcoDti2ysmqlbL
 2WWmqw7EWTyiowMA04DQts8zL0lUdKZzIEtwiKBXhBDx41jEFRsiy895Bwuyt7hB0bCw4yfhuNt
 /7XlBDkd8FaS9mWi/3qjQqVtLbKttHNUNMB0hmNdqbdvJCq4zI4tz+lXG2UfD23n1ePE/9w3hQH
 LDAd0ZPmp07Xa/dOLbXkSBoQZCors+A5qa2TPBL+vc440zgGigvaUMBkDO2fziCTCht9SWGvyOT
 c1sz12/w/tIIkopbK/ehIw9rjHJyfudI4jbwaojAtyQnn05Zl3+/h7QIDZkxocpJQuvyu2GQJx0
 oOA1fQDwhj/+hoi+VH9Nz8R0jAmCEOq/8iSI7a5LMMcfGAKJF/gVH75MS9Dv8sXJ7YHQcGaHKTO
 dP6tfyllgkNzl+4YSsGR0F3SQdWnaGDDi7Zodb7+ZVZsBX+4695d96Tf2CPD/cfpN+aTnnIkT2a
 6FDuSFhO3OrUwDWySFDJresWas7lj1rs9X7/JdMchANPWVOzfTBpiwOulFpwa4=
X-Received: by 2002:a05:600c:8519:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a1d760d830mr178658705e9.23.1792392952999; 
 Sun, 18 Oct 2026 23:55:52 -0700 (PDT)
Received: from localhost
 (p200300f65f19a9041674bacf58593a35.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:1674:bacf:5859:3a35])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm172293625e9.4.2026.10.18.23.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:55:52 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:55:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: tianshi12127 <tianshi12127@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panel: add driver for Smartisan TD4362
Message-ID: <atW-ch6H9WggWrAu@monoceros>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
 <20261017103250.800109-4-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ytu2emq3ghdudri"
Content-Disposition: inline
In-Reply-To: <20261017103250.800109-4-tianshi12127@gmail.com>
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


--5ytu2emq3ghdudri
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 3/3] drm/panel: add driver for Smartisan TD4362
MIME-Version: 1.0

Hello,

On Sat, Oct 17, 2026 at 06:32:50PM +0800, tianshi12127 wrote:
> +#include <linux/mod_devicetable.h>

Please don't include <linux/mod_devicetable.h>, that pulls in a lot of
unneeded dependencies. <drm/drm_mipi_dsi.h> already makes sure that
of_device_id is available, so you can just drop
<linux/mod_devicetable.h>.

Best regards
Uwe

--5ytu2emq3ghdudri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrVvvMACgkQj4D7WH0S
/k54LQf/Uhjypbnj1ODuf9SNZ0G+AxzxxiJPag9wwZDs7qe4jie8D09Q66x3TN57
yYyjySPnatXWtfX97FW4mzln9pMGWaHlUsd/S+FZKgDWm6Kl5UcwiNdd6Pq/Y7Ko
NMMKlEBaSDQq4IIiINzrblck045eCWfMz5lFU31Ub62gt8odV6wXiKJJdY8MAyZ0
gxiTiFrxi9umgHdrlZy37R3PVW06R1CYFyBR5Ou/cIS+6CQBKEXCGwOaEP2h8NG7
0dAOrN2EJcGqcImgdrzJEFn2qSo1GrOLN0euisKqSA2eU2uoX/pG990ABYWO6nnj
5dX+KkkM8ZyxJbseo8q/CT0upMYVaw==
=EMs/
-----END PGP SIGNATURE-----

--5ytu2emq3ghdudri--
