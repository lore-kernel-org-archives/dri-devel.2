Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E45C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056D010E283;
	Fri, 25 Sep 2026 09:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="RjoPr+YV";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B574B10E283
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:28:09 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so4207215e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790328488; x=1790933288; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GuAasn6M17RraKJz85D0VGepUYYLmKKd6LjzFHjVWiA=;
 b=RjoPr+YV5xrm5ApLK4qFAsgJt72jcBLk6cTbATMODfwy5Kh7DQ6aOguQ0pkMmujNFW
 imv3w3MLhTKykxdmXhv4IU7Ci4CfT0fWBmPIxSb/7zLZNsmYPyboTUOThBOkiSXoabu3
 a42fqtEJwuzFelx6ImogK6BVUvHABJrZZhUpRgFgZb5eEDUIYqbpuRpZj8F3kmti9dKz
 v0mGGRi87RRp8PcuTGMHUcKSfBBN3J/yVNhpQaaXcUNEGaNTIlUzmGEYRbDFpFwqKrQs
 15auWoK1ubc3TiwUODVew21qjxgAGlIEfGXNrqsIRbXOCx33W0wJXV9lQdZgukBZMXNO
 7oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790328488; x=1790933288;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GuAasn6M17RraKJz85D0VGepUYYLmKKd6LjzFHjVWiA=;
 b=uKK88IIF1vIQPbzobO1MvJGhXIUsVaofweaTqhUlgGq8ohbgRvsygM/HsmX1IF8pUM
 4jPz+Ts0etwwnAfwz58zo2cDbZqlnXJt2CMZ5NkyPxnXq9td04LtvFK2Xzmmi1eRypMl
 W26ciJp22LUK63K9MlZ7lorPatYURrmasT5Yv4oEbwSehtRN0ZhAV+F53egNr+qdiGGI
 FaY5Qj2methsna/QPclyMU2aaoAqgQvAbI3b5mk2Y0HdkEQ/5I3i4R2K+/k3fXEihA0v
 7md24VEeolLig0Kt22GDIdYKGuikY5+ovtXBe4Udm0sBzrQURSP3sT2sfklcGUEocHTo
 wAuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqcrMFFKFwML89E7KZROfuBWbetKmcnKApiOKpP6VglM8SRLIJRWmlf8hmcch5WIZV4Hbt8ABcrcs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ln9TkwBV5lZettakuFo9wj54ehR5pkbxtmJrK/Z8CTtWt1vNGw
 DIxrwf/RfZ2VySuyiQ57PmXHAX+xkwDsK127d5jykFGc59wkfkAtl+Te3ouDeoCX7DzBDBV37zK
 xHLXi/pGEig==
X-Gm-Gg: AYBFou3U0F6zbBgBc1/obCkHKuX5JvrzuhwGs1l9HmWQy/AhuloWi5xKVP0eLqjk7zt
 Qvv2e/+dRyCBOcvN1ThgciTxvSDBfoNCEqsGRUdl554vfj4I60oddsDtZDIZNPSSfsoqNNLiWz2
 9p6tUrOBpFNs84TrdgxzfZILln/GlLz/YljrWB5nsFbUHdMhaMicbZan8hT8MgwfP3WkPPXBqYC
 CYL6Mjac9D1sjniycISiYYmsxea4zoSxvB/lrywycQ9T4B3sgPNhqm1dtRweTJqU9AzUEucOp8C
 FmmknRlkRjLqGtiusMshHVg5nJTUendwgfM882TIOzORRqvzzepk7oMLNE/cJ2VCDGarmEo0890
 wStGgYTQJO2y+hgtruuy4HPnvKxZ11DOA1c+/4JTCzURAusby/cOvMzQ741HOoIj12A6Qi+b3Rg
 fCf7NYKKdCrQZHj22Zn9e/FKx7XlYhpUFbF4MC6TTV59MZcM2sTjjQKapLUOA0w5CxNuAspulJw
 ZdNh7E0WbsPR2NgWKK8sQHMxE6Su1dFhzTerbdVUkg8VA==
X-Received: by 2002:a05:600c:19cd:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49ff06f7a45mr28683465e9.30.1790328488006; 
 Fri, 25 Sep 2026 02:28:08 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee6ced69sm37140085e9.0.2026.09.25.02.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 02:28:07 -0700 (PDT)
Message-ID: <f1d25d13-4adb-428a-805d-d3e19cf1013b@suse.com>
Date: Fri, 25 Sep 2026 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/38] dyndbg,module: make proper substructs in
 _ddebug_info
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-20-9b6c217fdf2f@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-20-9b6c217fdf2f@gmail.com>
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

On 9/24/26 12:34 AM, Jim Cromie wrote:
> recompose struct _ddebug_info, inserting proper sub-structs.
> 
> The struct _ddebug_info has 2 pairs of _vec, num_##_vec fields, for
> descs and classes respectively.  for_subvec() makes walking these
> vectors less cumbersome, now lets move those field pairs into their
> own "vec" structs: _ddebug_descs & _ddebug_class_maps, and re-compose
> struct _ddebug_info to contain them cleanly.  This also lets us get
> rid of for_subvec()'s num_##_vec paste-up.
> 
> Also recompose struct ddebug_table to contain a _ddebug_info.  This
> reinforces _ddebug_info's use as a cursor into relevant data for a
> builtin module, and access to the full _ddebug state for modules.
> 
> NOTES:
> 
> rename section:__dyndbg_classes to _class_maps, to better align with
> struct _ddebug_class_maps.
> 
> names together, for more obvious name pairing.
> 
> Invariant: These vectors ref a contiguous subrange of __section memory
> in builtin/DATA or in loadable modules via mod->dyndbg_info; with
> guaranteed life-time for us.
> 
> struct module contains a _ddebug_info field and module/main.c sets it
> up, so that gets adjusted rather obviously.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> v8: set maps.len = nc unconditionally
> v3: squash in section name changes.
> 
> v2:
> 
> Move RvB after SoB
> In structs _ddebug_descs & _ddebug_class_maps, change int length to unsigned int
> No use of <0 vals is contemplated.
> 
> dyndbg: improve section names
> 
> change __dyndbg to __dyndbg_descs
> change __dyndbg_classes to __dyndbg_class_maps
> 
> this sets up for adding __dyndbg_class_users
> 
> fixup-drmprint
> ---
>  include/asm-generic/dyndbg.lds.h |  14 +++---
>  include/linux/dynamic_debug.h    |  34 ++++++++-----
>  kernel/module/main.c             |  12 ++---
>  lib/dynamic_debug.c              | 101 +++++++++++++++++++--------------------
>  4 files changed, 86 insertions(+), 75 deletions(-)

Acked-by: Petr Pavlu <petr.pavlu@suse.com> # modules

-- Petr
