Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1C1C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553510E8F4;
	Tue, 28 Jul 2026 13:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iGFsRMvp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E6D10E8F1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785244208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vxbqXLAunmT2qGsW55SMRVrOQZR4H5ggveSMTVA7VUM=;
 b=iGFsRMvpJZAlooHC1kvifPbLYQV/8DOBqDFH5Iuu8EaCfl4aAiZIl04+nV2Dizo1DakxZo
 C7xr3o+6A09+kFwEId/WCxc7Bj5Brdp75+PuDwzZAulA76QM9SgzN3URW65VKjfP0BgnI0
 Z/CIlCldvJe2xzFt3K550RjvSrp2tuc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-2Ke9NL_zOICoWgUgaqM7Ng-1; Tue, 28 Jul 2026 09:10:07 -0400
X-MC-Unique: 2Ke9NL_zOICoWgUgaqM7Ng-1
X-Mimecast-MFC-AGG-ID: 2Ke9NL_zOICoWgUgaqM7Ng_1785244207
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so483540185a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244207; x=1785849007;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxbqXLAunmT2qGsW55SMRVrOQZR4H5ggveSMTVA7VUM=;
 b=qf9tUQIxnZqAulXp6fbaWQKx/DfY6Pp2AnI8l9bgAO8UzI9tUzXU+3PTqF+4ZSEcks
 6ldr0W1IPmlzIzK/V4MFaEzX1PUBdukL9l7VyHVmBxz+MxgvX4xMyR6v8SRMUa3VDs+7
 xYoh5dap3XhoYr1PcbvNceEXzMK11ZmJOvO1qNOBi+LJoSwFK+5Mxn5PH3U+ZigBQiTg
 1myv+rVtJhrVMK0l8nTVkKl5yxbd3syWQC8lELj5IuMmwbBM8wobFTyUHSPtlXPuyv+7
 NwHnLYEPLEsGcUwj15eeia3/VKsBpAx25TTYUnwboiTF+EwLj42m2J+E/UEbqwvapoEa
 vQWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0PFnZZGw0OKvXYWgDh0Kg8wjswAGG+w9PoN22hitHB+i3kmhJN5aqHcpAXUGAxw2dnovo9J7T/1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMCoXvlxcgrLHTdbHrme5CNO25WZIEw0DQeZSv7zRPexMpbcqO
 2B/2el1G1OUOijdh9tNulFO9ZJx2Lgn4VHP4+7S2kgtqy9Pp8xw8V1VlDoGn/fJpg7U4B5cqLoq
 J6LStaIiTaQQjMK9kEOH2uI0yLp69vFV0LzaIHE1izrsD7iG6H1ExoMEBre4UNZIFZMvanQ==
X-Gm-Gg: AR+sD13enlA1fgN55sMucuqWF35Y3r6HdCEF7XqYxznIzbnhnDzF5kIq8XcsKNgCSvI
 ra24rZbl5m/UGbqXqgA/Ekg3o0tnEmeLm77SNLiea18KIchv9dNCFZea6SlGQQimNivOGEh47YP
 CsnveUAjYKYAScR2o+GEujKxAKTplFyv0vqufkOjFzrHKrBzK0XmAFEsJhnIJEa1Gr8fCJTSIqY
 XKry1fS66KrYsX5FckgOQzFQyVHfiXde5Bwnga7O53LI14COHGMOFlHQH/5Eqb6QHlwoDinlnky
 yXt15kBh7wFpWKZxk689bE45LRE9WDLz7OCnfyCzTVdr/Ppp9RmHteAaP2PEVn1UTPUgE/wZ2aS
 fyepR2tKhzxFwTkmjTSZYehc7kqeUQrJTb30=
X-Received: by 2002:a05:620a:4446:b0:92e:7a3c:add7 with SMTP id
 af79cd13be357-933025a4606mr215982685a.27.1785244206084; 
 Tue, 28 Jul 2026 06:10:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4446:b0:92e:7a3c:add7 with SMTP id
 af79cd13be357-933025a4606mr215965785a.27.1785244204887; 
 Tue, 28 Jul 2026 06:10:04 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de635f6csm831797885a.26.2026.07.28.06.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:10:03 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:10:01 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 YoungJoon Lee <getfeus@gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
Message-ID: <amiqKRkFItYwD6oL@redhat.com>
References: <20260728091804.382753-1-wenst@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fVsP-f3t0p70TSvniaLoaHovdCfejhe2oSd22kae2V8_1785244207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Chen-Yu,

On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v4 of my MT8173 PowerVR GPU support series.
> 
> This time around Mesa was ready for basic testing, using both vulkanmark
> and glmark2-es2-drm (with Zink). Details below.
> 
> Changes since v3 (all in the clk driver patch):
> - Changed pm_runtime_put() to pm_runtime_put_sync()
> - Added missing of_node_put() in remove function
> 
> Changes since v2 (all in the clk driver patch):
> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
>   - Needed since the driver implements PM domains using the generic PM
>     domain library, which also depends on PM
>   - Fixes build breakage (kernel test robot)
> - Fixed "RST_DELAY_CNT" name (Brian)
> - Dropped unused mfg_desc (Brian)
> - Added check of clk_prepare_enable()'s return value in
>   clk_mt8173_mfgtop_power_on() (Brian)
> - Saved error value for return in IS_ERR(data->clk_26m) branch
>   (Dan Carpenter / kernel test robot w/ smatch)
> 
> Changes since v1:
> - Adapted to changed DT bindings
> - Dropped driver change
> - Use same power domain for "a" and "b" GPU power domains
> 
> 
> This series enables the PowerVR GPU found in the MT8173 SoC, found in
> some Chromebooks.

I'm making a pull for Stephen for the clk changes. Should patches 1,2,4
go through the clk tree? Patches 3,5 go through the DRM tree?

Brian

