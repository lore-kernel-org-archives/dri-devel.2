Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F21C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CF710E1D9;
	Thu, 20 Aug 2026 11:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Q9xd0/oN";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE48B10E1D9
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787226259; x=1787831059; i=deller@gmx.de;
 bh=CnOIjo+zs4WliabTu7vx9+a45gc9dlI64gTepGRAZm8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q9xd0/oNdTnHv/pSMXxOZJw8dDOefyUUmrw3algQUgfSM9wQtD9tLAHkS9PJy2ME
 mz6C42aKBw3AatEdQe61xfgatMG7amc2j79Fg2xBkQ5/CJrS27VFlEDYWwvFXOfBD
 2JAe2Yrch/oo8zOQ2/Tiq6f3DxBpWL/CQwkFGQ0+5D7Kl6ZLmUUzAOQ2q657ah6r3
 TAUbY4ow7rnxEOFpxen4OOUtEoeWD3Vi57gz/F3mNo54sVYVioG1nSLnZzOpBRuN4
 g7ZTF5CNOPyrKaScUVDHuEPD2Ab4N8yBhTwv6eAjbiAn9lRRvdAkECTy4JpxawLx5
 OqN8r1m2mfa3iD3ziA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1wioI21oGr-00yMVb; Thu, 20
 Aug 2026 13:44:19 +0200
Message-ID: <77097622-e87b-4019-8776-4c9f943ec1da@gmx.de>
Date: Thu, 20 Aug 2026 13:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: platinumfb: add error checking for ioremap calls
To: Nathan Chancellor <nathan@kernel.org>
Cc: yuebingkun <yuebingkun@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260817063942.308926-1-yuebingkun@kylinos.cn>
 <5164081e-2eaf-498e-a320-c26c50b6f9e2@gmx.de>
 <20260819235918.GA2021182@ax162>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260819235918.GA2021182@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGUFPEt3zpCMNm53AQswjzbGmrxxHRRIRDvURWadFi2lk2nv9RL
 FhXtbg34LygFEACQ2ReJbAf3kTiRYVEpdhCo+069e0kJasPvn3hGL3fSSviD9sVLArVRBNO
 vW4a361HIGYDzz4Qp6b7BwwvBfgY8KUD29p9uaLBDzKmZjIgTAYUdhSu2/hHEUHstZRZe6G
 GxE45eVKAwOcpeqxtarNw==
UI-OutboundReport: notjunk:1;M01:P0:DMQ+nrPtDM4=;CFnzYp9+zz0VCaPcRjC6/Smb9MC
 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
 =
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

On 8/20/26 01:59, Nathan Chancellor wrote:
> On Tue, Aug 18, 2026 at 11:03:07AM +0200, Helge Deller wrote:
>> On 8/17/26 08:39, yuebingkun wrote:
>>> The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
>>> checked for failure. If any of these mappings fail, the driver would
>>> dereference NULL pointers, leading to a kernel panic.
>>>
>>> Add proper error checking and use goto-based cleanup to avoid code
>>> duplication across the error paths.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> That Fixes line ^^^ has no value, so I dropped it.
>>
>>> Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
>>
>> Would be nice to have your Name written out here, e.g. Yue Bing Kun (or=
 something),
>> but I've left it as-is for now. In case you resend with full name, I ca=
n replace it
>> in the git tree.
>>
>>>    drivers/video/fbdev/platinumfb.c | 36 ++++++++++++++++++++++++++---=
=2D--
>>>    1 file changed, 30 insertions(+), 6 deletions(-)
>> Patch applied (with the Fixes line dropped).
>=20
> This patch introduces a compiler warning for me:
>=20
>    drivers/video/fbdev/platinumfb.c: In function 'platinumfb_probe':
>    drivers/video/fbdev/platinumfb.c:650:1: warning: label 'err_unmap_reg=
s' defined but not used [-Wunused-label]
>      650 | err_unmap_regs:
>          | ^~~~~~~~~~~~~~
>=20
> As far as I can tell, it is unnecessary, so maybe this could be folded
> in? Otherwise, I can send a formal patch.

I've folded it into the existing patch!

Thank you, Nathan!
Helge


>=20
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plat=
inumfb.c
> index f74c937c839f..81fdaa3541db 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -647,7 +647,6 @@ static int platinumfb_probe(struct platform_device* =
odev)
>   	iounmap(pinfo->cmap_regs);
>   err_release_cmap:
>   	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
> -err_unmap_regs:
>   	iounmap(pinfo->platinum_regs);
>   err_unmap_fb:
>   	iounmap(pinfo->frame_buffer);

