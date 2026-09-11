Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF03C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260D710F66D;
	Fri, 11 Sep 2026 15:10:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bxMba2km";
	dkim-atps=neutral
Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com
 [74.125.231.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4735C10E3DD
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:10:16 +0000 (UTC)
Received: by mail-oo2-f43.google.com with SMTP id
 46e09a7af769-7fccd4c3f36so885112a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789139415; x=1789744215;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
 b=bxMba2km2Oqzt7+k9Bd/kLmrrDzqub4U5cz03NNnLyGewDWwGX04GtC1xJ/Ciqkny1
 7jITi9SCUeQXFhBUg5MdV9jlD2jfzObpJSXNO5EXSrUlV6ze1XR5Fbk8TZ3vFFiyr1NE
 nGzYTNXv8+jmFFuYTE98VQwZReNPeIMCCGUPA885GQvuxXCTnY6sMndSoejLfSfFh9r9
 TPbGlzmXNynxQZJedlY47EAkaBNHD2ZBL2/mUuVVBb5n0+zH1BDNZeKKPOuaklYhTvL9
 HI3Xw7smV1UivQ7dxM+3dYLjsKDejiWCFx52EukjBncHG0bhopVPNQBBSBuSIqV6oux0
 5UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139415; x=1789744215;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
 b=R1oexWgM+lod3v00Cvjvf9jw/V8tF+Sq4RrGEcJPJat0sBX8cEN37mpCJN14dA1ums
 tAaLkzN/RoDXo1EaPLWm81fS04Oz1b5JsuSPRlhxPdPqT4/yfTzeOA8zZMdsF1G4qPsi
 0MrNfNcOJi/KgITlvumTrvH4N+fHX2pJ+Mwk9f4grXfRG+twfuuDYvG+8jUrSh5MAvCf
 KVgj3eJ7DYDnu6m9Nt4NZ60aPoKHZZeUJ7v2l7JJTbUajh3uQcDJuk6QsFKk/BEcEyeY
 SMfChrUw1e2leAJzPRI2C9B3KfS+wkmx6ke/l7kBrW85rXFXbtJwSVztRuWeiuB0d5Ln
 LcQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBweAj2C3QS1JSlz601B3k00N35HwRytZCoxFCRi2m97xOBWZR44z/MH86oMKE1v+k90dA7fjFpY1z4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l2TCfm4/iXoI010xpsMY4ACCfoBegDkKo2kj4aKd7wA23N+bLu
 8HoojV7mbwpb9kHGVxoh5XHMwaJJg+dPi9SLdmTXOU2/qcddj7zc+Fw5efVPEaXOCLo=
X-Gm-Gg: AYBFou2ZA9OnF27irupTliQXvu5v3m7LvNgcunRJx2vv+EjlnkP4NHInabqEJD+3EC0
 AaEvp+jGVNhve0h4lGFYQh4rjGmhMG8JYGEf618FwRO00c8GzMUNZw4XBLC0d5BT9L2rXj1yLyC
 sdKx4qiAsAzk6LoSY82POMljzF/jdLAgbQPaf2szRe/tuDnv+wJi3Kpre5DiYAN6cBwPfTaiEIq
 sv8EYKou64jgE5flgsQdK+e0su1i225TvK3iFblj1vaxVrRGcpZ7a21Vit+saCp+GJ7mueFBnmL
 XEwDfYaDnCG/ztT6H6dQe8qpYDDk8dglUCi7zoVgZD6IERjn1gTMrc1dGCZZb7nvADkL/k0rhBX
 rN6wiXm50/uWkUCPyEsa4r/gcxff4cbVWcKsfLaweH8vrUAzpynlFdYVbFrhmE2ZVWRKbRY7wx3
 3GjKwmVxRmhTf1v//yDehwUfJFhlY/5poeo+9taJukgzvI0iGyXjmPHxUIG6Q4ZxApN1eA7BiUY
 bRShFy+o2pmnCWq6RPbofY/gT0E240e6+odtOxD/3MZ5sTnFAAXpfoh
X-Received: by 2002:a05:6830:82c3:b0:7f6:ec23:7956 with SMTP id
 46e09a7af769-803fe1bd730mr7936240a34.2.1789139414671; 
 Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f6d1875csm2548656a34.22.2026.09.11.08.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Message-ID: <258d93cd-a18d-4860-bab7-2c9c7d43a015@kernel.dk>
Date: Fri, 11 Sep 2026 09:10:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: Include error-injection.h for
 ALLOW_ERROR_INJECTION()
To: Petr Pavlu <petr.pavlu@suse.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
 <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/11/26 9:04 AM, Petr Pavlu wrote:
> block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
> asm-generic/error-injection.h. It currently relies on this header being
> included indirectly through linux/module.h -> linux/error-injection.h.
> 
> Add the missing include in preparation for removing the
> linux/error-injection.h include from linux/module.h.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to shove this upstream somewhere else.

-- 
Jens Axboe

