Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2536910E11C;
	Mon, 10 Aug 2026 03:24:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhxQCHf7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kw0QwyED";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D113F10E11C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:24:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LCaJu4102320
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kvbFwVVBMqfv/umXyteNcSRhSoeZzKe/6uhNTUR5reQ=; b=hhxQCHf7EVaebvmp
 iHj+HlSAhrZidDdj+JanmT+LlfGNFTmrqCkG2Oil/7x+/vfzmfhgVEweBFrGPuA1
 1sD5HUbmOCDG1DyxDEKfnhxpVqHcfre/U56GjZE7vIP872hafAQFfzrqBM6mIMxQ
 VjqcQY6Kp3w6GZiQW/0tlPnM1sgWxBs6EbHF0Jsiduc32+H5qos9s9laeSbSpkKz
 jzjxiSJVK4cj7wwamYSYbAAJTNiM5WmuSNHuzfqO693no4s6EaeWgQdYmfW05U8L
 mH+hEjKr7ARLnngwQf4Z+eU8uQQUHV8V7Yzm9OZKLbJiSS2CxxviWHwz4Q1+yqLZ
 G1xk6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xrmya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:24:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e52306621so115537985a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786332292; x=1786937092;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kvbFwVVBMqfv/umXyteNcSRhSoeZzKe/6uhNTUR5reQ=;
 b=Kw0QwyEDIALLW9DlD+WG/Fcs6ADrqaIBD+d5+JEiYQVAYGPKNUgl9fTfDbdWkTguEr
 NeHdw5halr1dvuGB9gOV8oQYNFDVv57HBnE22ckqJ8cyDU6wuY0ASzFkfOadmnuf9y6s
 A0vLQfL6N2V6WqIgZHJKL2b1L8nmqTURHiSjh3xa88mvH/1nlHZYNfIPK00xFM04zHRj
 VxNBvTfLqDjCaOX1bhUdZpb3qDWW/I9FwBl7KJyVWbFarTMqBhRK2TL+xbjJE4eSD0Iv
 4rEbNJUzREGCkR0m0OHHWi7YZsHfVukoQof0VSQ66pCEATMYkRDXFHoTAALswEoqat4B
 KkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786332292; x=1786937092;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvbFwVVBMqfv/umXyteNcSRhSoeZzKe/6uhNTUR5reQ=;
 b=ElxFed/4lYCSmZYRfeOx61ovZPWYquE9BaqTMCH7r7MqWm6IDfv3crwuTA6s0fG7AW
 ZJGE5QrW0DfbD1D3drnUWXJ0mvZm6H4viPXJnnzorvpycv/t3KXEa6V4Sgyzy+BlJ5sN
 /2YxyBbZOcKDvjl2/DO+yQCZ4ECBvgbTvRcGfzmty+Mos053XHQHRNEcMy/PNibrT2Z1
 8s9qklt329XZX4hICOCrBnO6Rcb4Q39vC4lLdWGO8uE36i75LGS1bvSbva5k6gLntn5W
 5AOfskf0qjZT206SBoYID/84a2omYKiBpQkww0guKtyo1AAW7N0mu/vupnY/+7giK6QV
 pl6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVMksAN4her+APTIeSgyiBGXOsmR8ZRd5bASnuvMWPxUiHC2hBOFPPeVtvIImAIKn/xfiGT/522fs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrP/tNfu/xPhsewwfa47J4RaN+GbrV0M3fZHKH823qTktKjpk7
 HYCw5UkyLnXa7RvT3FFUqqQrw+LZ+QzJ5Y9+ITuWVQFzju5Bhoha/6wNud7a7KT4/RRIyDby3TX
 gM5wr6uFSoTkoEygiC7VIE6Fbb85g6c7dFMyafw7G1SeYGxxTN56eJ2a2prZObFFa0NdpzgU=
X-Gm-Gg: AR+sD11k/b8wPLoBx9BmkG5DjmWxcpB/6mmu5+0IxwJGlRmF1trOKKWv7nAVgFOU0v1
 LXqK4rr35MKc2FxEV7s+SZR8+iP9jssEO6mKc710XX+7/10tOzmWv73axy9xEZ7iBMsj52PIOp5
 NXoH4JpOZEoCk+E7qy/Rc+9m5wpuewspOssgVrD/c3aq7FX6nL4EFFQbOg8TxaXUE0NEUBAQRfO
 ehHc6BUjsDljGEaqRTtlBT1VtpYS82Nbaqz8mMc8Jauoh4zjGPGtXMqweIxc6gSqsPNmGkWJOkZ
 ciuIcRsm6+iGghOYPyTCQjpdGnYflnUQrUe428pLbOMJZNo6zQ/GbSimxXiCcFswAg4tPpqsW38
 DC64cjHseagb3hHKh5ZwAEfhsCWXQSY/wYjk=
X-Received: by 2002:a05:622a:2b4e:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52ce622aad1mr418905911cf.41.1786332291800; 
 Sun, 09 Aug 2026 20:24:51 -0700 (PDT)
X-Received: by 2002:a05:622a:2b4e:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52ce622aad1mr418905621cf.41.1786332291317; 
 Sun, 09 Aug 2026 20:24:51 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995427a244sm376443725e9.10.2026.08.09.20.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 20:24:50 -0700 (PDT)
Message-ID: <8ce99afa-1162-4910-92a4-6cb2973ea977@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 05:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20260809234810.982500-1-rdunlap@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809234810.982500-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyNiBTYWx0ZWRfX1oXr+d6vDhQ3
 YsunFijrL/0qwIfS4NqTjv7Hi8mgL24bPw0dZyqLDI3/oPnOwvKrkKCqO4FTqS5Wwv6h2E2xLpR
 I63mG5MisP7Idr3TfE1VOpls+4Lql2Y=
X-Proofpoint-ORIG-GUID: k48Yzz_ObenvZnrV-4tR_p95FxJOEG_W
X-Proofpoint-GUID: k48Yzz_ObenvZnrV-4tR_p95FxJOEG_W
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a794484 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=BcPKCTjPAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
 a=GfA0_eoHWwQSGlj7o5oA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MNXww67FyIVnWKX2fotq:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyNiBTYWx0ZWRfXzu8sdHvxu/g8
 YSMHTWYTeVgCZQSdR0KxEvOEzj1eUfWmcJbE/qgCgmB1ni41pJEvcQVH8g0npD+AkOq+1pZm0PH
 +s7W0+tI7PZ+c3o/ZpFuNhE4e9CT7AgYKl0ramlif7iq2heJ/bY6vrdsDvbOdATeyTA8e0buRja
 47XCWpiSFS8/gbOLPlkNaz+njVjZaYiJaIwkgnGfkFLrp8KD4oBQnhY6p7wnNmcu5mHTg28CcfJ
 gd280h8prvKyavTp7FQjWbNwv4yZwBWhcDr5iCY85LLSwmPuJIczGqy0E6+NewieA/QDfL68U0c
 yyojxdcMBRLStLg+AzXXX5MhSokxAYk6gZ+lOz7GpF4QNGMWBxR9lczi3EBZPz2oMjkI4e1wMmx
 4SxAI69KFCPG7DTrKjQgZMCszpApHM5c72GDQ3ZubHiIlTF9HcMPngr5NZRw8r/i9Cj6uZ+Ni89
 YHUCzb82Qh8wnOLcNdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100026
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

Hi Randy,

On 10/8/26 01:48, Randy Dunlap wrote:
> This is all ancient source code from the beginning of git time.
> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
> 
> Fixes these build errors/warnings:
> 
> ../drivers/video/fbdev/maxinefb.c:64:6: warning: no previous prototype for 'maxinefb_ims332_write_register' [-Wmissing-prototypes]
>     64 | void maxinefb_ims332_write_register(int regno, register unsigned int val)
>        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In file included from ../drivers/video/fbdev/maxinefb.c:34:
> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_write_register':
> ../include/video/maxinefb.h:16:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
>     16 | #define MAXINEFB_IMS332_ADDRESS         KSEG1ADDR(0x1c140000)
>        |                                         ^~~~~~~~~
> ../drivers/video/fbdev/maxinefb.c:66:49: note: in expansion of macro 'MAXINEFB_IMS332_ADDRESS'
>     66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>        |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/video/fbdev/maxinefb.c:66:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>        |                                        ^
> ../drivers/video/fbdev/maxinefb.c: At top level:
> ../drivers/video/fbdev/maxinefb.c:74:14: warning: no previous prototype for 'maxinefb_ims332_read_register' [-Wmissing-prototypes]
>     74 | unsigned int maxinefb_ims332_read_register(int regno)
>        |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/video/fbdev/maxinefb.c: At top level:
> ../drivers/video/fbdev/maxinefb.c:74:21: warning: 'maxinefb_ims332_read_register' defined but not used [-Wunused-function]
>     74 | static unsigned int maxinefb_ims332_read_register(int regno)
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_read_register':
> ../drivers/video/fbdev/maxinefb.c:76:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     76 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>        |                                        ^
> ../drivers/video/fbdev/maxinefb.c: At top level:
> ../drivers/video/fbdev/maxinefb.c:114:12: warning: no previous prototype for 'maxinefb_init' [-Wmissing-prototypes]
>    114 | int __init maxinefb_init(void)
>        |            ^~~~~~~~~~~~~
> In file included from ../drivers/video/fbdev/maxinefb.c:34:
> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_init':
> ../include/video/maxinefb.h:22:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
>     22 | #define DS5000_xx_ONBOARD_FBMEM_START   KSEG1ADDR(0x0a000000)
>        |                                         ^~~~~~~~~
> ../drivers/video/fbdev/maxinefb.c:119:20: note: in expansion of macro 'DS5000_xx_ONBOARD_FBMEM_START'
>    119 |         fb_start = DS5000_xx_ONBOARD_FBMEM_START;
>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> 
>   drivers/video/fbdev/maxinefb.c |   17 ++---------------
>   include/video/maxinefb.h       |    4 ++--
>   2 files changed, 4 insertions(+), 17 deletions(-)
> 
> --- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
> +++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
> @@ -61,7 +61,7 @@ static struct fb_fix_screeninfo maxinefb
>   
>   /* Handle the funny Inmos RamDAC/video controller ... */
>   
> -void maxinefb_ims332_write_register(int regno, register unsigned int val)
> +static void maxinefb_ims332_write_register(int regno, register unsigned int val)
>   {
>   	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>   	unsigned char *wptr;
> @@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
>   	*((volatile unsigned short *) (wptr)) = val;
>   }
>   
> -unsigned int maxinefb_ims332_read_register(int regno)
> -{
> -	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
> -	unsigned char *rptr;
> -	register unsigned int j, k;
> -
> -	rptr = regs + 0x80000 + (regno << 4);
> -	j = *((volatile unsigned short *) rptr);
> -	k = *((volatile unsigned short *) regs);
> -
> -	return (j & 0xffff) | ((k & 0xff00) << 8);
> -}
> -
>   /* Set the palette */
>   static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
>   			      unsigned blue, unsigned transp, struct fb_info *info)
> @@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops
>   	.fb_setcolreg	= maxinefb_setcolreg,
>   };
>   
> -int __init maxinefb_init(void)
> +static int __init maxinefb_init(void)
>   {
>   	unsigned long fboff;
>   	unsigned long fb_start;
> --- linux-next-20260807.orig/include/video/maxinefb.h
> +++ linux-next-20260807/include/video/maxinefb.h
> @@ -13,13 +13,13 @@
>   /*
>    * IMS332 video controller register base address
>    */
> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
>   
>   /*
>    * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>    * is 1024x768x8
>    */
> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)

The change looks correct, but clearly this has never been tested
on a 64-bit DECstation, so I'm not sure having this code being
now built is an improvement.

What about:

-- >8 --
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ac9ac4287c6a..ff17afe6b8b3 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1436,7 +1436,7 @@ config FB_PMAGB_B

  config FB_MAXINE
         bool "Maxine (Personal DECstation) onboard framebuffer support"
-       depends on (FB = y) && MACH_DECSTATION
+       depends on (FB = y) && MACH_DECSTATION && 32BIT
         select FB_IOMEM_HELPERS
         help
           Support for the onboard framebuffer (1024x768x8) in the Personal
---

?

Regards,

Phil.
