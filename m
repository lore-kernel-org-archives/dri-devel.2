Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8772BC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F8110E661;
	Thu, 30 Jul 2026 11:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jKbvJ0Hd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075D010E661
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785409565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HWoRuuEQ7zJ3vpj2jIwSgIRqCCpU7QeZRVoWtE84e0=;
 b=jKbvJ0HdzF/Hdl0dG7ADEhOwMVzoUR6D1J/Eugd/DXIIUEWtye0AVff+53bpodAqfqRryW
 6kqyihG2lZcOim8NtSAIbrU1FdCjOveTbd/+L7vUZcsAFEaB+qRvW7BIesRXB+3QXU95nM
 mfz2s50kRsGLRJ++OeHEwlCNa4zddA8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-9lPYd2QRNje8FSpFmD-sjA-1; Thu, 30 Jul 2026 07:06:03 -0400
X-MC-Unique: 9lPYd2QRNje8FSpFmD-sjA-1
X-Mimecast-MFC-AGG-ID: 9lPYd2QRNje8FSpFmD-sjA_1785409563
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81df8abfa7eso69439547b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785409563; x=1786014363;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1HWoRuuEQ7zJ3vpj2jIwSgIRqCCpU7QeZRVoWtE84e0=;
 b=YrL9UdMW8V0Rn6/hMYOKa+6XlIZEi6iOtpUM7uvdeoTo5VxSyIHoG2g4BWpI66ipDr
 E77UwTzAfsT6CL+AIIJ7TKY5VGVDbXPzXzxMg/8Mu5lJAlkqCaB4IwaTcWYYk4/zLv1j
 pByxCEmfootjY0RhTxpiN+5uwUAb5BNvgU7cO0kcmNi0x6NxbW5Bt5qs3kcnGkVENqsA
 0eGncUqxFWmwDxmNHW3faLQypS66uq9xPt6JfQUjplC/4yyrW3dwXR1YUOssulwE8xon
 6i1Za7kv9ynOd2uZkaDTKgypH5fycvpdKXm+NDxxFz2etrMo4TkWhgaB0DRl9Z4ky9Zi
 +5sA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre8/v7+fA1BfjE4K0jJaimagrSNSVPhfblmm7/g68ufsUwsV9BrFziBwg/bc94IeMnVuTI+63cvfg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZE4sJHWfenPjnP2IX3ok1ZR0k+Dr7bGeOnQYt4Ad0+xmr4ZJP
 jnG1USKWpv6lk43/LIiGEfNDxRMo2TaAXdW4tAJF+jVCIYXOJiFFPGeMqkcEWndHxkw0PcwecLa
 s9VFwEdEN1/ML9P46Yp3CCstS6WWf/TseKjSC/CjX6zvqh1ubQ0iwhEohj7DSfhcm1uhzGw==
X-Gm-Gg: AR+sD10pGrwH2NOUbfcMuVKd6KaQa+H6U08ip86Gg9Yv030vpJbn2/WDhj9JZuGsODD
 vd1AFgiosNCVw/D9dDxkB5B4Rblslg3lT0x4ryTc2HVY3YtkqRFc+3c0FjWUlXtzkHgqYRZyCjX
 JYFHQcDoMrGaN3hYIRocMHkP2828wCA7M2Lek0e42WdRQ2zrjMOFxodafxdbRTok89pzTdZbmf3
 29ZQSB/eRx7OjoniS/+/rlgTMU4SaB0P6tAmATsdA64c+nrspPrA+4TaXc4RFBNMfQ75/QksvaT
 2ciV4lNdYl/15UPrP9tw2vKJd/l25xoofagmZVI57ud/nwulQpvkM68XDq+FIB4Hb9wGoNtfDPQ
 IpfkuzPQDk6FY6jNeB7QO5QhhUK4SE1klwbY=
X-Received: by 2002:a05:690c:6802:b0:7ff:1a06:472 with SMTP id
 00721157ae682-81fb8953b7dmr15182057b3.4.1785409563062; 
 Thu, 30 Jul 2026 04:06:03 -0700 (PDT)
X-Received: by 2002:a05:690c:6802:b0:7ff:1a06:472 with SMTP id
 00721157ae682-81fb8953b7dmr15181697b3.4.1785409562604; 
 Thu, 30 Jul 2026 04:06:02 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fb8b2975csm7687837b3.48.2026.07.30.04.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:06:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:05:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
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
Message-ID: <amswFn2qWkvypMH8@redhat.com>
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGXv+5EgGYFVt4TJCysQgRqA1J5=Qz9c0oWY5YTxgc5PnNC_AQ@mail.gmail.com>
 <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
MIME-Version: 1.0
In-Reply-To: <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWoneQmEEbS6plKYurR-gIa5XAe04q1BPWR6HKlivAE_1785409563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Angelo and Chen-Yu,

On Thu, Jul 30, 2026 at 10:23:14AM +0200, AngeloGioacchino Del Regno wrote:
> On 7/30/26 06:51, Chen-Yu Tsai wrote:
> > On Tue, Jul 28, 2026 at 10:33 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > > > On Tue, Jul 28, 2026 at 9:10 PM Brian Masney <bmasney@redhat.com> wrote:
> > > > > On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> > > > > > Hi everyone,
> > > > > > 
> > > > > > This is v4 of my MT8173 PowerVR GPU support series.
> > > > > > 
> > > > > > This time around Mesa was ready for basic testing, using both vulkanmark
> > > > > > and glmark2-es2-drm (with Zink). Details below.
> > > > > > 
> > > > > > Changes since v3 (all in the clk driver patch):
> > > > > > - Changed pm_runtime_put() to pm_runtime_put_sync()
> > > > > > - Added missing of_node_put() in remove function
> > > > > > 
> > > > > > Changes since v2 (all in the clk driver patch):
> > > > > > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > > > > >     - Needed since the driver implements PM domains using the generic PM
> > > > > >       domain library, which also depends on PM
> > > > > >     - Fixes build breakage (kernel test robot)
> > > > > > - Fixed "RST_DELAY_CNT" name (Brian)
> > > > > > - Dropped unused mfg_desc (Brian)
> > > > > > - Added check of clk_prepare_enable()'s return value in
> > > > > >     clk_mt8173_mfgtop_power_on() (Brian)
> > > > > > - Saved error value for return in IS_ERR(data->clk_26m) branch
> > > > > >     (Dan Carpenter / kernel test robot w/ smatch)
> > > > > > 
> > > > > > Changes since v1:
> > > > > > - Adapted to changed DT bindings
> > > > > > - Dropped driver change
> > > > > > - Use same power domain for "a" and "b" GPU power domains
> > > > > > 
> > > > > > 
> > > > > > This series enables the PowerVR GPU found in the MT8173 SoC, found in
> > > > > > some Chromebooks.
> > > > > 
> > > > > I'm making a pull for Stephen for the clk changes. Should patches 1,2,4
> > > > > go through the clk tree? Patches 3,5 go through the DRM tree?
> > > > 
> > > > Only patches 1 and 2 should go through the clock tree.
> > > > 
> > > > Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick up
> > > > DT binding patches. Otherwise I can push patch 3 through drm-misc.
> > > > 
> > > 
> > > Not sure if I can really take the DRM bindings patch through soc.
> > > 
> > > I will take the devicetree ones exactly right now, even though it's going to
> > > give warnings.
> > 
> > Apologies for missing this, but the first DT patch depends on the clk DT
> > bindings patch for the clk ID macros. This is causing build errors in
> > linux-next right now.
> > 
> > Not sure how we can fix this right now.
> > 
> > Brian, would it be possible for you to split out that patch into a
> > separate immutable branch for Angelo to merge?

Yes, I can split things out and make an immutable branch this morning.
But it sounds too late for that.

> > 
> > Otherwise Angelo might need to drop the DT patches until the next cycle.
>
> Yeah, that's so bad.
> I'd be happy to be able to resolve this, but it's too late on my side.
> 
> I should've checked the DT patches more carefully, my bad: I got a bit too excited
> to finally see this PowerVR stuff working on MT8173 and going upstream.
> 
> Sadly, I have to drop the devicetree patches :-(

Chen-Yu: Could Angelo add an Acked-by to the three patches, and then I send
Stephen an additional pull with just those patches? Do you think he'd
pull that?

Brian

