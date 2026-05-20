Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C44DCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B52510F140;
	Wed, 20 May 2026 18:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="r7zWBCeK";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EF610F140
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779303083; x=1779907883; i=deller@gmx.de;
 bh=G6xkkVjlI6ZoUREp2X+ZLC+Szjc4sFX7UNAAEsOkTGc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r7zWBCeKGp+39WUCmnUZfw/M3F+gfZyuy9/ng3aY/KBqYtloV5JZrEl6EPhldXER
 YtgVUylC2N+LTUse2Kz7FwNOctisUjQ4RDUoz3sM5T2rV5iouKcuuxC+LO3n8QKK8
 bhqOLnmJT/XPY2qLYWByvmrK/fOU/nkkPofR234vSB1aFLP0+rKkGTUx4h12xAz82
 706pvAZmnbnFZJ04DZxPQHht7g/nvezSNn2kO+v314kGGU+KLUnImCxkv74Blu3PR
 03DniOFeBL/BAMg5oHvw6jkFDWXOoQwcn63gJCnY4cNq5AQI6oD1FE4LX8nXunmlN
 I70xAASbk2hp84+1bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1wckR60HOV-00BhCl; Wed, 20
 May 2026 20:51:23 +0200
Message-ID: <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Date: Wed, 20 May 2026 20:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fbdev: Wrap user-invoked calls to fb_set_var() in
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260520160744.130841-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jm03I80AqYIndy30iKmD9r+Zdl1AZUWrFuuaTiPwTD5+T9Gv6Fp
 /bgCo74En7A+U1Usqe61DP4SHiqLU5GSdGdPJpFdscsyY0a7H0bwughL+L7yshfQhbzXL4k
 v9bYMVNzG6Y9PoDfQyGPAZp3ptZ80KHOPO29ALVLOqE4eQBhrOklUJHZtgKuhxZjp+s1gRs
 XbX9Nta0usANYD4JkI3Ww==
UI-OutboundReport: notjunk:1;M01:P0:pXlyvPsMoGE=;nHBJTa4rgW/xeZm6vwWWsDE2bpl
 7E3b7AZB1C39nhXTp65VHDOMPQ367SQG2bnR3mS5YDA/jVeGtI11rlR6/yUMvh7OYUJSqbA1S
 R7go4nX+7PcOpiI2gjzri+s5QQdFZA4p5k73e3QaDUO1lZB3rbyuJ3k8hKXLjAYJ2QyrCphYS
 8EE5AJwsP+HEt9L8bVSv2WdohtqZ+LepGGFPDcz+DU/DJx51/xWXU4yg2FSkY24XpodtLLfJh
 zCUDpYWcPpgdttjFoAfsm7FFIFZohkUCOazaSGV9FpC//mVaRSKb6LuTz1/d6cQr+RuSd5w4+
 IU1P4gYyaj3pys4UaTxyrPx497z/wJom0hjS9poUpAbIft4oXd4366ExEFQ6ufW0a7q5V5Kjn
 7vlWILmf88pjcFj7utYbBwRYz1GcY6Hblr+ISHS3L97ZwQLOEd4+rJ+A/1xS89Up8BF9GM9IO
 4vT+9MjoC9U2Pw6xrHDlURNy3VnvCJkp8X6aepSexrdv2o8E76KZcZI9DYYoihtP1P2LMv57p
 BvMB18gWeqNXBYi1mrFqPKAmiIhfpwT7RMWd95iz6L9Suj4Eb3BAWI17IyZS8LVTKFGb3Vnr3
 VplIElgFf1UAfeGASHZwOfR+yxqz6kKNj8/TUuk8GEcxg8OKgsTAY0NIUanc1ppBEKoYWC3EN
 jJggArR7xtaIdwlc6UGD8wvtcJfsxdkEn5cmpGDN5a9j/sR3SpKSoBEFUeb3oOrIE5ZHqYSmx
 zvAKitNXKBFJ6EULMaNHn0PpRAOuZowRwxVQXfHauJJN5xBMdVTuZOrAS1tskEoVPiAQ7A3fl
 OBvqAAILwQot22TsT/uIoxI9Th6co//K7giAnpAOGl/kZkOdC92cmqKR0Pu+jsqO8c1CCEYRI
 xhqrfCD6+i4OFUFOjEb39d1oID5dHMfGrzXBvRzfNeVmpC2kSZakw81RAkrHLA+IzoDXflHIs
 3ZwUiRWpeDVaRF0jtHVQyGyr0TzousO3xql4OqYx8z4lE3dREMQeXWIqmqZ/HOr9n3+U4832s
 tPUvITJ9YCFr3z45Z8zJrGIBlZQj0oR/0ktkldle+ae3blQrTQ0jAUq835/ReAYJjG4Xm/aUN
 UuocPDYsClYQGAybDCSUTITl512z8W9kaNpMfD74pN0WhJNsqfaSYhd0ANfJVmQj/rqpstqna
 tMMpG9zFA4oPZtDQd0VUE3GcV0JgZWcrXr7KvSglaQPhbsTPNa9nygJgAJbaJINhTNASfjonF
 AXBlp/tBOXSVy58TsX6HmoAV1YDuwAgHNRRFfyA0A8FawY+7xYoo9T78lLpDIsuKMWy9VpJRZ
 QGWluwxbg1xbpQV2CCzwPFLz1CacrH+qZgIe0QgoG5DarAknBBnK14fekeJyKxEbPbom4DRBU
 ODGGj/E1WvNoO3HL/qI3MSYMQRVxGjCkTdtMnsaErCmZuubmCYBGdGVqRk+y8mYmuoYwgmmM2
 MgO7vhVuuEyESfm2xPH7/4QyY4duDvvqalYDIeegDsTwksetDi2gYnhPxKcRNSKyOuepaIwHn
 BiLBHLZGmSVRoF93pwRxxYC6cBrpU/EnbcMqgD8mSSnzGYNB1PA9jcjLL6pbzizSa2u4iSW1V
 Kvpb6Hdl+lK2pA+mAN2MAjLvKUP0ZW9b8V68Pd0mzDOMaBtoKgF/xBD39p7iydZcj4gAINxKT
 Kuw9QeWW9iDHtUIW+y2Ttr+eVIu+k758TnzXkoDqro2/K9KvPniIzk4pqVWFhxhOQgikx1+DT
 eXW95qtXHN5zQNqSybvSn1QCGE+Iv3bDgDB468e3QdGBfYaZAERNIHKxmMNBKWkWCUDNdMi1Z
 XgTBxTsfmfQjvb+sYikmWWcGh0ulboXfqMv1O0XL8zYVevqWqn3h1AN1RuC6xemlNOJQB2GuU
 GhgFB5gJl5svFWGpPeCGWxucoZ5rAGvLJu811QisUL0JEb5zEcFjl3zmBkVxWGX2Bwbp1/Oub
 RdGRyHIUT7z24gaI7Jgb4imh7evAuQHh1qlhkrlQ7b3z63LWirZGJ9CL3gV6P/lAOMZ/TcXHl
 wEMiGlAhHMcxhBcQx0VnTF/ukbFwbtOzKIICKITQ8Vvs5cWacpzivqfoLqu9vWsovT/oGOU00
 LL9vogcecoujGDSHfHeKYKGc81RC35WaQ1Ud32gS57rR3cEYKPhYyfyMiUgJdGUqA8TyAfO6O
 i3EcVkhsxcXfSmVJ/pQCuMx1alXrqoifCVBpiijBbaqcZfz6O6ZSLEc8DHiTS4zsWysXzGQle
 dXo4uolr6d89PoM66+dF37ssQlYv6m4A7iAFFyQti23pjrZYFiDNV5PTxeblgIqEj6qq9yn1n
 1WL2nBgV8MoE2pFACbdSkX915x4Bd/9LN5FptC8sqgMLt+7wi1HJLlp7WPqqbDH1ksb+9AsTO
 zOVkajYEyi22rFxUL6jB0qKCXL+oD3nyyMQJJuCMMG+WJ2/jgtOKJs4+eO1TldztCDRosd9AM
 eIdf0/sgVq0gm5Vay+6KsUoWRenSgzmIOsUkeZnMkYlQq49PLDKzdr4PedPKl+YoRlwfDXr31
 vU7X8DK/1LfJbCvYgfpqWqymzPLa9p475+OSpD43K+3bdcR/5e29EzS3mqTqtEXa1vCL+jIVa
 d6baxnjJ1jFOrAnCOtn8YdDWehyVOcF31V/3IvWokrBaACRIT1GfdgcvY6tIPkpPW73lSNQTU
 47a60dQYol6H6LCXoaDAAfzWEXiP0mRDQ0kCjMkPmSV6rvscogVFTpEXDmN1AKvf6sfIPf0S/
 wnEs3ZZFLEdnDHtqyVTLffgnox+rKQJmdQ1qV8y+FpT9+AC3oOm2N7mhwcE6tBCE05veYa385
 SqN6Zc5ie0W/Vx/ugrfBrGiI3hXat+7fmYWcCsVlvZw9/IdluhKzjLwgI+D1y4iShaJZGr+Y7
 No7ou6ExlOoGvLRx+1UNXmUzDrqxAamda291rSePvVwkD3cDCersd5Klc0ZtKYq5zB29LfjMr
 CLLXxXb3onRdpaOE1iT46r95hBEREBEECApktS0+Ok3nBWOxneHHWEy5FfUM0lJbSkXgdQCOC
 EqCRv/biUyhbhcNmbl8hu6+rMw08IB4n/0QFLL0qT/CvNzrHWw72X7fhnCMWg/5mA7I85hJEW
 AuermkWSL7b5a3qoLJ784aQmDJr5NdWF8P44QX1Cj9PX3rDQqV7rNsoac6kWTyqlvRX2h+JA3
 nwkIGNP0zUhePzZTVgisr7WDDCoDtTYazaPwwDln4f2gsuY0fxVq262gXSBTHtwBTk/wuyYYs
 Jv5wI37fyZv4vP1yjABY7qR9RLIkXWi7Tay3WCWoXjUGjv+jH6Q6yUg8Qz8ku5dHwoPRKbdBr
 OuYqHZ3qDD19hdGs2dUir89RHlgE1WU+jDhQ/rYD5gc7z6xsQEthiaTHedC34wg3nYXnCXVVa
 ohUfbsMZfNhAngHrKpOzQwYcB6ApVnjnlzVCh5uHTZ/khHBCk9SVDY0Fsi71id3+aBOSPPVJh
 Fu3VKYtezDLBb27p766Iu1KMm3LrOQr8blQ7FPRUYM6mEzIfasP77j/MXJmsl+kO+M+qxxptv
 zLjVEHv1KJTNsgg1taPKWlFwuyyxd4TXq87lLYdgrzXTJgrndD20eY2RfxeA2SpBmQi+//My+
 5bBR0MF0lYCacnozCeTU663EnvLOxTSz60uLgsUv2ENTMV/mupm8au9GELlMtf/AM64fpjpH5
 p8xCnUcI/lS3dHrK9mFzzRB8wqVefLZRmwlNdbpmlnoqqS4B8Hkaj/YwccIOgxicGC9fC4Tqb
 yjDLEQNSa+7HjFj8yMBO+B2tGp1z9Xab9ESPpwfWqiKwFAGtXQJGsmDrwKYLbcDIWRqNpnfPm
 pDkrZ4qe4HjIsbXPYHoXatK/sYEbvunwUiIeRCSwnL8QxI3geBSblpnXGObpQiA40PSI6lKaA
 ShdSoTicl1caHlK5q/Nx/+grPijYFYY4yI0A35OsqtKjhvhzdY2GZo/ivXTOt1LvF65p9s5/z
 +nzrUKKq3LYqrqia8VHRX6cCJpFoUKTRyQf8oiisEhBjYJlrjiVXGuDmNCqm9pq/js3TaJ5sG
 ylWejyZwSebW14pi0upE8+x+nGZq7Y+7E4zI5XgYtwYV6wZwacGZ7aL8qITBcLdWd4YHdy6qg
 0b9GEFmDFMiykZBkAQTGI3O8zO36FLXnF+adR7EPPrQvZuIFMop01f6srvlFzJWUayWtJEyhH
 Typh9ON2Yt743hCk7cixj1+d+EzlOWVGjhh5QzG6QxQCxmtPwGDsaI/N/NHkUOHbv2UX7dmF8
 X7UELPzTGfeFpSrbmRqNDQjUc2Y622Z1dwp+rTDDHb3tHQqMAF3UaJvM877bUhrf3cv/rRSwK
 gqQ4tuA2pMuetqgJsk5gc+MrrArUTeE0sE26buumNIApg9TeZo/9FAdyWsBaYZZKX0mgGT0zS
 tLSv2ihf0mVamHDhi3/otMpOuejSKDmzaFcwmIhYOizV29Hl3xlsT/7jh1rtqXFIflFMPQ9vI
 ghRRI4JRGSX9urulqGNnXyMCK/NStk9gReAkVJsR22VZPzPzcwC/GFToV3q1ktYA0ZMyPfYgH
 Kw9hDqkwzVE1OpVs3xkwdnHd5Icq1FC2Co72+z5t8owdRAhbI+pBNLIcEs4UGFzKQlWyxvL4d
 g7cASQzVJ/ATSeVjcvnSCowvjM2GeroW2cvn1dQl+hyX0l1Dd2jQB5yWyk89iZPo3E14yadIY
 Sp/xoKM04l0FwiiYFB7J4JW3Th8nGgTEL8zo9WIIF+KTeF+pXnkgfTeWDtAA1RwczOw/eSCFv
 3moiGDZSPTT/t1aMBNmqL7ssXESX0ASQTLva3g+Ploxp6ROmPQi7cn1nHwCWaE0gDp1apZmuJ
 M2mMPtbm5Esb8uKI7+xM/lvEdjc4F1/Bl/jUX1H/e0UrLC1P8XShdOtL1Qo/ajKn9sRbqpKfX
 PfgpnOzc0g4I8WoqhnadfpRW2Yxx5ValEjuX3XXIMp+Tm7Cp+MzWFrUNRs2iXvHMCLBXUq9NR
 XfE9MR53tCH6MzGJ/AK/3wUBlqLViuXjRYHgkXDY09KE97zbDh8OAfgvdvR8eXC/X4DOC9DT6
 wPhuKnPxBHt+thPi4Aq6mvkkrIMj1oQuUXXscdxkXzh9cvSsKA1XwNO/EFbYcpCeY4TIoblDn
 celqnQEoK36k501EaMn6MTU03UheEtmrWOvwbHKgYqse+tEXCRLjlrZx65ckVRmjtEV/yaPFA
 hb4OKsRL0BHHmTmOR0LhumSB5y9Yr1FBq/Zu9rt6CgcXpYYlFC9/ndS1fqgyOxUTX8aG5tb9k
 fN0jqHz3WzM6+53Y15Bgk4HHscmxG/M9BKg7FF93iw9GNojeJU+rY2ZsaEXkz4uCV0DrpNP8B
 2NJU5yVDRtw7dROut4cufeLyWuLiI6l0L+V94hMfcvWT7P7PZENFVsE6me9ZYViu2FgBTXuQH
 1StG7GkLv27UNPmEFHneRW78dQG9waFDRLIj/ZDcQfqVq0+OokDje5gKK1fjZBmvZCEl6SFZZ
 o7ui/ACAIsdRVH5JFrC+x29PHgVOOysv+u++KQ5ELyh2K5M7vB95oXYTWg7cYHSt9MsHN4nOz
 CqEsHg==
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

On 5/20/26 18:00, Thomas Zimmermann wrote:
> Handle fbcon during display updates in fb_set_var_from_user(). Check
> with fbcon if the mode change is possible, update hardware state and
> finally update fbcon. Update all callers.
>=20
> Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
> mode-changes callers in sysfs and driver code are missing fbcon-related
> steps.
>=20
> With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
> fbcon state themselves.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
>   drivers/video/fbdev/core/fbcon.c       |  2 --
>   drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
>   drivers/video/fbdev/core/fbsysfs.c     |  4 +---
>   drivers/video/fbdev/ps3fb.c            |  5 +----
>   drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
>   include/linux/fb.h                     |  2 ++
>   7 files changed, 19 insertions(+), 18 deletions(-)
>=20
>...
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 5178a33c752c..88680a7cabd5 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct f=
b_var_screeninfo *var);
>   extern int fb_pan_display(struct fb_info *info, struct fb_var_screenin=
fo *var);
>   extern int fb_blank(struct fb_info *info, int blank);
>  =20
> +int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo=
 *var);
> +

"extern" int fb_set_var_from_user(...) ?

Other than that the series is a nice cleanup!

Thanks!
Helge
