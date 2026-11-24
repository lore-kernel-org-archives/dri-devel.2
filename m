Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HKidqfUD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823E710E326;
	Tue, 24 Nov 2026 11:25:03 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E5A10E326
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795519496;
 bh=m+QktASoilhpAu5jCWRlhhnUzEWwf0rcN1O0jXft81Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HKidqfUD0IcjQxD6en+YNVjDJQ0sI43LaDJhDB2jeA6MFVDhqieRSvJGtqAvlrm8j
 +52M527PJXxwiGZtMN3RayKqMMnNMndXcnxUJTlZwIkMViAPUATAD3pCIrSFrakjO0
 w46uiz9bTgr6VDfkzRk250nOJ9QZ76purJlAcs+O31yD848ID2sqwPtkLjT5r70FGC
 2MtYpQV2w/WXbtUMNtX9BM0FUjzAPHaKlwEDuH85pnf/s3umOlQuw6lb1FNfnnxGX5
 Oac5GfU7x+yUJj0F3WmEtxU0jlEa0CAHnhveouDy319G1PKxaB515gni9AIJXZg+Da
 y/9Na3NcTKD3g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7FF3C17E0309;
 Tue, 24 Nov 2026 12:24:55 +0100 (CET)
Message-ID: <56cca340-b7b8-4e6a-adbb-887864cc14b1@collabora.com>
Date: Tue, 24 Nov 2026 12:24:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 =?UTF-8?B?WmktaGFvIEh1YW5nICjpu4PmopPosaop?= <Zi-hao.Huang@mediatek.com>,
 "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>
Cc: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?U2hhb21pbmcgQ2hlbiAo6ZmI57uN5piOKQ==?= <shaoming.chen@mediatek.com>
References: <20261119033634.1844084-1-zi-hao.huang@mediatek.com>
 <fe208c0c-cea4-4e56-8283-e242ac1cd2ae@gmail.com>
 <65140b86aed23f307f8552be8bc5ae13f1de1874.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <65140b86aed23f307f8552be8bc5ae13f1de1874.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 06:54, CK Hu (胡俊光) wrote:
> On Mon, 2026-11-23 at 18:31 -0600, Ryan Brue wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> On Thu, Nov 19, 2026 at 11:36:34AM +0800, Zi-Hao Huang wrote:
>>   > I'm not sure the trigger is specific to our downstream driver.
>>
>> I hit the same lockup on MT8173 (Amazon Fire HD 10 2017) with the
>> upstream driver. v7.4-rc4, whose only DSI change is "drm/mediatek: dsi:
>> force command mode in mtk_dsi_poweron()" from the mediatek tree, and the
>> mainline NT51021 panel driver, which also sets prepare_prev_first and
>> sends display off and enter sleep from .unprepare.
>>
>> The trigger for me was suspend under Plasma. logind's PrepareForSleep
>> makes KWin turn the display off, and the session is frozen while KWin's
>> commit is still in the panel's unprepare. The freezer's fake signal ends
>> the interruptible wait with -ERESTARTSYS, mtk_dsi_host_send_cmd() takes
>> that for success, and the late CMD_DONE lands in mtk_dsi_irq()'s
>> DSI_BUSY loop. After the watchdog reset, MT8173's last-PC latch showed
>> CPU0 at mtk_dsi_irq+0x84, the DSI_INTSTA read in that loop.
>>
>> With only mediatek-drm.ko changed, suspending through logind with a GPU
>> benchmark running: without the patch 5 of 6 suspends reset the board
>> (about one in three without the load); with this v2, 0 of 10, with no
>> DSI IRQ or vblank timeouts, and the panel's power-down still takes 270ms.
>>
>> The wake_up() hunk matters. With only the wait changed, every command
>> waited out its 2s timeout and the panel's power-down took 10.4s.
>>
>> Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # MT8173, NT51021
>>
>> I actually had a similar fix ready to go, and found your patch, so thank
>> you :)
> 
> The upstream driver has this problem, and this patch fix it,
> so I would apply this patch first.
> 

CK, okay, apply it.

Beware though, this will block at every frame and lower performance quite a bit.

Cheers,
Angelo

> Regards,
> CK
> 
>>
>> Best regards,
>> Ryan Brue
> 

