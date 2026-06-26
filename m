Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F545C44503
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8CD10E5F0;
	Sun, 28 Jun 2026 11:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="W75NJiO1";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F9110F686
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 16:28:08 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so1540816eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiscrypt.com; s=google; t=1782491288; x=1783096088;
 darn=lists.freedesktop.org; 
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDlz1t/sNAPG3n8KvCz8DSwA5gxZyhCvMEvXE1/4H1E=;
 b=W75NJiO1vUztW48ReGYZvK7gNLy3pzt1idmRMxoWHKpj0hWkWnlpghKqDMFElvAYxY
 /mrMa2bKgnJWfV043Pp5/q58Ukw6gQHch+wP8NU+P0RTXKxbAUmxiQ33tdmQDf0RR3rj
 dGw4dxj7DwgpkjuxgsV7QDWcC2NnD/3YeJLFaRHZyScCkiGGOhL9O4xdXBMq/S/OAjTZ
 hdr71dd6OThv8Ctt0HTZu55NU5UEXCPgA4WGXj9bO4YOVCs2mCFv4iwiZWTSQz9glT2c
 5bWy4W6SQHYfqfdabZht9fSlzX2Pd41zpB3M9OBtBfVJR+xfGMOy4pe2ptix/4xoD6ul
 XUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782491288; x=1783096088;
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDlz1t/sNAPG3n8KvCz8DSwA5gxZyhCvMEvXE1/4H1E=;
 b=pbPjv/CXm2oeQtJt4/HnS/90S1isQsYVdqgLI9Gmmh6r2b9X7wYw6KNWUPyxhHLv34
 bZRlkWjsDWWnSwMOnKM0OWjLi7wRNlmfKbjWkPYF9LJCHlbfOo8OCanoB4uprWXmlHWK
 kp+cOKPIoup3f2m9AiHvXnYA9QK1y8jxijU4phxZi4mwZKhK8G5mo9HTaG1q0aTuRMvQ
 raheWev9kYSYOudouTfw8ZL3AwhPjyaRgMJQcseRbHY7VbVeXcpFWZsF4HJf4eQE9g2d
 mCCHS6CLguP/4W3tPn7NZBwVGBerEPOrKtptvmbAx68R430CfYSxG41FnMQX5AI18lGC
 5rnw==
X-Gm-Message-State: AOJu0YyfyUZxMRwUnfYtUp98X7d+W26XqxAwKSrFa1Ya/sc6zs0GwbCS
 9m1nxnKVaDHO63ZayyFlNRcbRdP6z5CvCNez6lNrb6VZC5cCUux/BAvrt7EVo5oxuxn8EL/3ZhL
 5RrmZ/cq7CFE=
X-Gm-Gg: AfdE7cm7FaTNeykpfuj0rTgpx2Uo81jeOc5ytQIPB/5AZcO2fU6rncsA8zBqTAP5CmG
 K5dWBzYYfV5jv3zEb1z+yfKM23zPBhRKJJ8oNmFtWKghF1YwaYouI7XZSS8dNThfpBKI1qoqTfY
 gO8V5CI1bbA+HS2Kjb2tRBJTbZ5zg4osQXoZ7I7TMsSG7hK5Iz8e0RGjxf5IU5qBzXnzX/x1eiv
 m6UXzNxq2Ft/Hjqbu1NhJ1pMjOlmlI2i0ulkIuowHUVFix9/BLGoGM2THTe2Lx1uTBKeyEhuxwj
 hEvOBZ7XNyIp52gsGAfx18XC5YPrp2Jtvhi2ef39G1wDYbFZiCfw4Mzv3If9yBan5bfXi4M/yXp
 YGUmmZB/pXfNvAgYh4yVdJ/YOkTsLTom+0uX3QueiNuFjo4jYqVmFk5q/LLhkiGcMN2PXVWxYn5
 1ym1wGA7K8TSQvcuuGTNMk4MpBu5JJMqA5plG11DhHmRqG61XZKDk208fwI1fwYIlnlTPGwEizT
 njX978XcAjpJ9WViIcYpqy/pzANOmoIZ5hU+8NGPhs=
X-Received: by 2002:a05:7300:aca8:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-30c84b8a06bmr7042782eec.14.1782491287807; 
 Fri, 26 Jun 2026 09:28:07 -0700 (PDT)
Received: from 3.1.168.192.in-addr.arpa
 ([2401:4900:1c07:46d8:7051:ea2a:333d:24da])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c58831asm20964574eec.13.2026.06.26.09.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 09:28:07 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com
Subject: Re: [PATCH] drm/edid: check DisplayID tiled block length before
 parsing
Date: Fri, 26 Jun 2026 21:58:03 +0530
Message-ID: <178249128387.45639.4597289611502160129@digiscrypt.com>
In-Reply-To: <3bf6abb4dfd22771b3774f22a4be9b7f647668fe@intel.com>
References: <3bf6abb4dfd22771b3774f22a4be9b7f647668fe@intel.com>
X-CodeOps-Marker: e7215c2380654283847703043a11999e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

> Already fixed by commit faaa1e115583 ("drm/edid: fix OOB read in
> drm_parse_tiled_block()").

Thanks for the pointer - I was working against an older tree and missed
that. The existing commit covers the same OOB read in the same function,
so I'll drop this patch.

Naveed
