Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71424C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C729910E308;
	Tue, 28 Jul 2026 15:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FVR5Tleb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C17110E308;
 Tue, 28 Jul 2026 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785252531;
 bh=u5GQmvOgz4Ap+OJsBET/yAI+gwsxy9J0r+fVRChxE/4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FVR5TlebV/hxNwrPhCiD7Ji0XburW7Kl8qwY+ztKJCxBPz9GnlFRTcKRElOrfVD+L
 JZVoqVkWeHsHP7m8XHiG3Vtd+CDmRNy9LrnMQYpK8tJjrIdvlefamXuenCU8+0jdSq
 OPqRoJ/v1I+WDRHK1TRB8YB6z6XcaFj95hw79wyK2gwq+qVuGaF+F51Z+RvncRdTZ5
 xnLt9tbKqaYVmvRVRsKpw6xuK4fiHFUkHvFYRRi2yDvl1T+tXj2rsYPbjXV3wdh8ep
 d4awa1OLzLnNI03rcOQCQ5b75xyZ5a1n50LcnwhlGOO09qfj9jzVCov0C1dUFML4eK
 8RfcoXDp6U8wQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F5A317E015B;
 Tue, 28 Jul 2026 17:28:50 +0200 (CEST)
Message-ID: <a0ae9525-9288-4d13-a080-9cb3d965d536@collabora.com>
Date: Tue, 28 Jul 2026 17:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: wens@kernel.org
Cc: Brian Masney <bmasney@redhat.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 YoungJoon Lee <getfeus@gmail.com>
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/28/26 16:44, Chen-Yu Tsai wrote:
> On Tue, Jul 28, 2026 at 10:33 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> On 7/28/26 15:13, Chen-Yu Tsai wrote:
>>> On Tue, Jul 28, 2026 at 9:10 PM Brian Masney <bmasney@redhat.com> wrote:
>>>>
>>>> Hi Chen-Yu,
>>>>
>>>> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
>>>>> Hi everyone,
>>>>>
>>>>> This is v4 of my MT8173 PowerVR GPU support series.
>>>>>
>>>>> This time around Mesa was ready for basic testing, using both vulkanmark
>>>>> and glmark2-es2-drm (with Zink). Details below.
>>>>>
>>>>> Changes since v3 (all in the clk driver patch):
>>>>> - Changed pm_runtime_put() to pm_runtime_put_sync()
>>>>> - Added missing of_node_put() in remove function
>>>>>
>>>>> Changes since v2 (all in the clk driver patch):
>>>>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
>>>>>     - Needed since the driver implements PM domains using the generic PM
>>>>>       domain library, which also depends on PM
>>>>>     - Fixes build breakage (kernel test robot)
>>>>> - Fixed "RST_DELAY_CNT" name (Brian)
>>>>> - Dropped unused mfg_desc (Brian)
>>>>> - Added check of clk_prepare_enable()'s return value in
>>>>>     clk_mt8173_mfgtop_power_on() (Brian)
>>>>> - Saved error value for return in IS_ERR(data->clk_26m) branch
>>>>>     (Dan Carpenter / kernel test robot w/ smatch)
>>>>>
>>>>> Changes since v1:
>>>>> - Adapted to changed DT bindings
>>>>> - Dropped driver change
>>>>> - Use same power domain for "a" and "b" GPU power domains
>>>>>
>>>>>
>>>>> This series enables the PowerVR GPU found in the MT8173 SoC, found in
>>>>> some Chromebooks.
>>>>
>>>> I'm making a pull for Stephen for the clk changes. Should patches 1,2,4
>>>> go through the clk tree? Patches 3,5 go through the DRM tree?
>>>
>>> Only patches 1 and 2 should go through the clock tree.
>>>
>>> Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick up
>>> DT binding patches. Otherwise I can push patch 3 through drm-misc.
>>>
>>
>> Not sure if I can really take the DRM bindings patch through soc.
>>
>> I will take the devicetree ones exactly right now, even though it's going to
>> give warnings.
>>
>> I trust that you'll make the binding get into linux-next before it's too late.
> 
> Rob beat me to it. :D

Love it!

Thanks Rob :-D

Cheers,
Angelo
