Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E8BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47A610E51E;
	Fri, 26 Jun 2026 13:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="fPzmHy5N";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C5310E51E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782478961; x=1783083761; i=deller@gmx.de;
 bh=wcTgOtBc2+vUVvg7eNQzUqDaf5OUo9LAK7WunvHqHo0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fPzmHy5NBdZNAhg77LEFOS1g1AsWAZWGGljOB3diETnSPd8qmBHPOi58B/KIrA06
 Q5ZbahPTHTGEzQIP8gje9OM+xQvOmc45Z/NPaMLb4peDiPYFatWwwFQegD1o2SgBs
 s50WHwek99yfIT+0hHZ7wdqJb+1B4hkkUZUAHj7S+crcYiaOJAlDi8pDpnrsETBB7
 rLOneEnEIDelEFhAwN0cL3hLdUp15jRbYRwhccpHpqwfhaEpqCUk5s1OtqhuToFg2
 /ApgHtJ0CxmaYO3eqH8rb/Ya3B/t1AYGIBbtqmg4I2m222NoNjw+I2rOm6HU/fKex
 e76YDUa+ETgYitC7mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1wSKgy0MFl-001PCd; Fri, 26
 Jun 2026 15:02:41 +0200
Message-ID: <adf1cfc7-6107-49f1-9d2e-7865a8a3ca27@gmx.de>
Date: Fri, 26 Jun 2026 15:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: fix use-after-free in store_modes()
To: Ian Bridges <icb@fastmail.org>, Simona Vetter <simona@ffwll.ch>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <aj4FKJtIuU97rEA4@dev>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aj4FKJtIuU97rEA4@dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:axc9K6R5FvKufBWXHHBBGhUwpNZNNuYtT+Q77Xd/MZKkmaY1V3E
 curvunZXuEPrc5xcVtC7DEVnbAwIuvG2gLyGcoCUIVHVcxC325497lahC2QlLLzjNTQEdcF
 6ofZ7GA16RbAsFUmntd15tCFqmY0h/Ufs3Ots0PVUYFEwYUXJJFCmrMu72y2XPBTcppmqCE
 XldGwwA+rT9OSA0GSrTRA==
UI-OutboundReport: notjunk:1;M01:P0:7XYudANVYZc=;JQTICf7tNgpqa9VMqH1KOGyqB5M
 rb/mzUbnh0tAMgCsXCiHq3C50Gw5dj6LhjhV1ZxvvW8zXmAgDY1qsV4elbgwkDpIRmZAwzavI
 FYAmOF7e7DWjPG59vERdpVDT6uAfUV6XKlnWA5gGtrGEyadUxe/CPoRf6914L9nE5hrhBlZX+
 ZOUjhiaYXA8+SAq+sVB//xs3uvpKqWcRhSh3sTu/zWAcclNqaJraRteO8pBa6MtxIEfz+0o8m
 ha/62s3WC2gbr0XlGGXTeAvig3XQzlVmCMthdzB5+QJpucAy6ccRB8k0wbP7s94qIoptMDOD+
 3rS6g+h+gjM+5cqVY8egRIcZnm+u29BUG0HQ8BZlUj4A39Yt4bOI76qmEFXrE/vb5NwXyXSHw
 ERBOlQe2IV67ACYSpjvfmJgMLEGU0V6FFT2GDkRjyutp4VprJVfsbWHnhlpA+mFt/87YFbWvp
 9TgHiWDgS62KXfIaqVy6wzHAi/0WkphJCCGa0rceAq9XDcxuvETg0ICkmzIvnWdMd5kF134wa
 TOwzWDoTOUFOdBS+34W33NCt+KHQ2L4V/PLTcU2tOBtkGw3laKMoHfYNb4HtINF7WDst8YFgU
 XNNaKj7dTesvG80mkh/ZNkHDrHsvw3BbnMCmEoQxECA5lXBOeu6jrWdKffE8yWPpBNiPHbfMX
 hIYXl42KOCh88bQlagO+0HhINZEcHGvhc2bkhwK7t8O5CGq5rCtOlCJgchLveNbmFWaIKoJ5T
 tfTJIFIcoVkBEUtqI4onyWZDMD98eCzKXhTUN9iB5HMVp/B14wm8j25kG2o45bqldFmHiqujv
 Jh/gliLBQveMquQPFxcc9GTredfqUE5YoDefZWR7gINLqGhB4TXReJt2Ff10uHXOO2uCZXmta
 jt9LF+j0BaYlXtR5EqimbZTjKBeXJfqywFKJ3YWKzMxr+5p5hwi2UcKuFUztlG77iFY8XD3bG
 uN5iexG7Rw7C/ijVrHCk4AVlUrdCGVBxksWrbYcrlYjKTzR2X0urHXu8DXoFm82RozF/gk3wy
 QOCeY+XmvqDu6kOeTanGHjew6RWlEjfnF2G5xqEbLqszCPoRStKSGDc1gi2YcFQpteFwnQOSp
 R2zcfE1AqPpG5Zxly8y8sg+nXtkhEZTFjvaKhlA2t4rJsPpA/el7186Xdxj5qX91QQ9lTxbSk
 6hUp5Q3PCPl2RzLMVUhFwJcMXUFM7b59/2q11Omj3CDki1oLPwrZQ2DaSptC2L0Hl3NbGxevK
 8T5g9DRANC1Tx7vIJ/JfqCInuOZcJNGyeTab7fCwLysfNwo5LnI2NoHC/qW+odC27qrtZQ8yV
 869+vx3E739T+gU2HWsw6w9EKYzT7A+DAIKktT78BVA8hg2Ligj19SKNjcohBAO6Wt7LdUMqP
 E4gc5pZKQfkeHymmSdNr8TZw9O93Gvh0QTMpVmww6+PFZhrAp4dYwYrCvGugPngSrIYBn5okT
 Bo/ycZg8F46VBr1mCmzxeQ6IGOW1sMrarQffjnspXge6ZjVKD22vZC3Rvslxo1bAv9x1WmYnu
 Bc5XUmGzwh/MEXqIYyYrkPjt9llSqpSWDWnnKpBUsvbbKV7oplCRWkpxEVb9dfyUudG6ox3Ea
 2kWFriu+EnQg3NWZqiFdFdI9r0uzEE4QbXxKPDLwY3e59X2fc9fY5lCTljghHr73iOptZbVQX
 Z9T6vYWc6dqOURGl3aAbA05U7JpEpjk2v3YlryH/hhJBXprL/CkNIk5wsbaztvMS72qj2CuiW
 dyOxkERuaWgMRmx2SBnyXoowzKfWWmwBTfwB5rT3uNY4BMoeiyb4N9MQZkayQbTvygHyL0PvB
 tu0dGuY1i1tZ8aEgJg/Ek+0dUb+uFTx5hLLwHffpIPc+S2wMjmFdnDhHhgvRt0S4OtqZYgtxv
 zuE8jytj5UoIMKIEuB47SkG4bHns7zAddXkgCEdlYOOvSscDKH/nVt491WBWBX8DpgkwaLMNl
 u/J0MfmL3xVe69hbhrnAOGJ3WQVk/X0uVw6rVcKluVCQoI/jDxV9ESboVelZ6nZxUzEQ1Z+Q1
 3WVFLG72O9lax7ZS50GR+yVgmwZXnW57OHq3Cnek0xdHWn5qOhtwJHIl8XjDUTlzmMe2IDG1y
 5e+WYk/QidxAP+nrzP25wfQS+VCv45IuaMs2Y/o+uiW6WPv+yAXvAenhmyysX8H3+54Zwct6c
 nbZDKZ+AhMdODCX8KYIVE4elHymuz3enCCuSWzcELmDAqIzpwodfte3TdJi8K2y8mTpq5UrTf
 rsOGcDDFIhpB5PBw9HIqNhhB/QrcTIHP8VJLbOOo6d7KA7+RsI2VkBAqf9W0XX18QvyEsv0/v
 9AakhPkUOoTu7f6G7rdiMG0E8eHfXBEpZfe2sVhYjXAoYtAk/glRftte3nRj6ZwwXfSmBckSD
 hphVTPUI4T+UNIESUK/nIYi//3IVgQJMcUsCODwG8MM9R513TOS7Q/AvW6K/gapkPbvISPJs4
 iEdQTD5XtVjrB/IGyPRC7e4TbGcNIMB9O+LelfqEpCuOSXfXQzxlrsFk0WN3jj1FirrcNnMJ8
 ET+y+t2kJz3rFcxUeUJPBGdPGI+aYISTb4guW+DsUAGJvru8Qlb53z9wl03sU5NLH09bsNaNd
 a3gj9Zt+nV67UyHHetmsxP2pyp+ZWRnlJzZ3/AJkBu+Qw3/bviMRgV894TgWe7fpnG3L6fE9/
 /S3hoNt/bi2RHeH7EFM8NmeLhujhoZ/lk+WQD7AaZwu9fqA7RijimmrgkZB8tG5WsC5lVdtu3
 chO7FPqIy1q2dnm45QHk7sudZvzbmLquw12qvBvVI8xVyLx7rzFcGdz0HUQ0ELFkD49/f1C68
 6i8KC3nzcaZWL85zdRgOhph91z0CCEUBe9n5oEzNCE7/kexivnVAfRTM4DTgeYm9CcmTFJhX1
 296HvznkyTZjaY4fMZ7IvdcKE8iylgKCFhk8py7wsrE0uvRTbLq9G8pFaroFLY3wIuuJ2wi2f
 RDs58OMfe7FJ3d8+LzeLr5cddom0qqokGq7KbotvwDLUl2H2SG6u7eiCtiLy7mT9YrBDxw5qB
 nwZjM8W6KMSXnYLMI3cy4AS9/M5pEML5SAnyMtHrySMkE+TJUAEFVsL8enVXKCrjwrCFLjYEq
 EYJYZ3Y3TQeS1251VKSxxlmrX29Wo8hMNTQyir1VJNottL3Kcj2aYeCCLmc+gQcFuoWv2aMf5
 Ro/jzmhnBwyza+CCXjJXqu4eiNbhUu1qGJF+Z5lel6+gfLkFB2vRdzdbAUqT0f9tqUMPuxyWx
 1SsGjqDmSrXobzLzY86CgRNPmMicCulz1rMMqIKVu4Lhxq5BzywB6G3zq86Yxq9f6gEDoerwb
 OnPFQ4lyvTwqtIkcBIQQBn0y03Q/GQjiwSAwUMST88KWZ4FLEeXjc7jyqtbrTUyBvE30YfzFq
 0+4HY3gmLTWXyJn8iJ18T+nIu/4Zr5Ju4/0oad32CdAFn35CbMzVzkaCP01oX3O8KC9XpXD1X
 mrJM60r2InhuaAjTq/KQ+8yl7hkmoS5QhAcnSPX4cwBAA9S17gD43JqJ4Brb/yah+XhM96cNj
 mYFuMt3ZyhW16WIDOnMaxLuoNDCJMufgExaba+z1VuilPnbREPP4/W3nKy2EgJMD1+SmN1dnc
 YXGj9OQfICV23DcFuYrjydYBXnM9QIMofOiRpUc7PTq+PAEmpdGBSoOPbZOFGUoyS1liBlCDh
 tFQMEe+aj0tthxb9dbb/P+qsHy89msOnYiT7b6M9uPs5s6zTCBkS/91JaTR/gwbp0Pl0jXAsV
 akzHNfsUwKvOSQ3ius4M6zzClJBs/EnDSvApQyHA11ZCGqaON2AtPCgv4T0SXhqqyMa4ujROl
 0gF14nw7ABJRXAZHcBzElQ6MCPCPtrbc4O3gK1dFCOa1/bROGTSC6DRIa8TtvW5sPUUTqbHsN
 0g+nYTM0o9eWs+fTWqSiyJnEtMEco10zwP4TR5N1sm+lMTHBOhuqXAUnrOg1u3QvhIjWO5Vnv
 H4j6cM2L4hlYDcEzjnXCOY28keytkzvQp4UcUovpabO+c9K2Dd3RxDH1Uj9DSVgpY8+K5C8S4
 toxKHMHeP2h4gZBTiqFgRoTXL8vPYEJZ+0QaLSgoItn1cn0Z/tAQsVxR7m+H9Uuc5NaiCjYf8
 5+Ej1XyeJ6tVVT1QIRVlNXwt/DMfjjKH0nAOSwznctYhGSk8yY4GOQ66PhgDQ/8suBkg08Ux8
 jo4/lSqesnBQZzUkSFkU3hO7PviSbpwQmyXigtaI5o5Z5BGuh4hSAQvab4KSkErVHj7fupfGi
 48JYBfn8K82UiYcFXTu8sL1vwcvGN5mzwwyqiihTSSCM7H2LWAKzCAbz+YYeYMLcPhyo034V0
 p5HGOEo5siHhw8xRaaQkax8uB3KBKuAYYn5DvFhS8+5jCO4q4cjsuLyx4parJmhoSECjDdXPe
 89cg0uO/5NdU6r4LKH2oVSWUR2k3IejT6ljYzgB8M8yQb4dTZlZaHME4TsQW+DE++YEEw0o6q
 dF+vTxV7ecEuTzptAX3AXOzlIWLui10tzJJiIqESiyWYP4CkjXh763RR3PGohpcw7UiaHNRYb
 CRccKTQ0mfW4nCKUApjrXrPGxGRggSjFn/4yTz6VCVmY2ZGBQiGVm99LsQSmMw1aN1YDp4G3B
 KJ7/TyQm/SJ6gtDMdkpT1v8hYZ+6Vq/ur0uI6iWFt26gFefm28tLp82sLJRa+0xZkYmexnIkD
 dp+cWmcUIfhzrgrhB/IyEJ25RXU8SZEdZlzHBTX1RZmPFoKYUIyhT/0iz8rDuKwKOfIlnoiW1
 z6xekpMX9+2HNcs9WRWGCmk9oRZi5Smhq/NzDTKeUUHnPyZocAAIVu09Tk4wnF34RI7DF35DP
 KXN6NzonDWyit3xcuTpaenCXXMbIyOflRegMi4wyoPFI5D0uz79+SKjDh+ssXBZmVvl6HbS2Z
 UMTHcl03rtbtm9D4DPYFEApeQWavOW3JpdumqOvi409S/IQLaCpghRM15OYs5r2rqCQWAwZ4R
 UVgGRd/WcoE7aQswofA44l7IGCLGalbEJeDqx4297GgoGTq9i0pK1IN6UK2b3L1RNik0PsUtG
 ziyTjTLqJwuxsNYp/TdN0OO8ByeVzLXFcRGKw5/X/XbNrHy3XQyoXoO5bgmu0cDNDQ6ARo0cH
 t2L+zZ0/++sZ0g2VgkT5OH9cw625+35wQvuHoWVTRv/DPGweoHlPSg4Ri6Iy/QO5MvwosfGBx
 +yoaIfHdtOopF86wPwpWUHlxKNEl5vNxobtQoRAoo4KT8dn6SAPzt+1TpoYeut5HnfHruXlWp
 rUdOtd3CyE6/1yUywmKOylFkX4hPGZFFQUmP3V3+TUpRcnT70PdNWPEAQWZuBmSFosPXOPRHq
 wHM7jx/G4AOf0ELG3hDVwhuOezHuxBlVJt5VUU0DdfGQP+FlJTFqg21XDujoygEpxcBODH67K
 dAnDTlNrqsmrlHTTaa5mFDmKaifbbulelLbwcWzbpRS6PhF9TW7r5zSlsRl40EBcXWG15uTHF
 OecjJXtic3Rm+FLRV4WUu/4lfrPdRADb+PdkFysZ5vhAOHVFaxilMXnmnmEf7AeZjqNoAAykR
 D7bmBGB7fgyxqPkbUpdsN+2LyBypSk4QPGB2WTv98wmO92zVX2IBPEqHNXqoSfAPFSI7bv6hn
 YJefvnEEDCCNG49nwM=
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

On 6/26/26 06:50, Ian Bridges wrote:
> store_modes() replaces a framebuffer's modelist with modes from userspac=
e.
> On success it frees the old modelist with fb_destroy_modelist(). Two
> fields still point into that freed list.
>=20
> One pointer is fb_display[i].mode, the mode a console is using.
> fbcon_new_modelist() moves these pointers to the new list. It only does =
so
> for consoles still mapped to the framebuffer. An unmapped console is
> skipped and keeps its stale pointer. Unbinding fbcon, for example, sets
> con2fb_map[i] to -1 but leaves fb_display[i].mode set. An
> FBIOPUT_VSCREENINFO ioctl with FB_ACTIVATE_INV_MODE later reaches
> fbcon_mode_deleted(). That function reads the stale fb_display[i].mode
> through fb_mode_is_equal(). The read is a use-after-free.
>=20
> The other pointer is fb_info->mode, the current mode. It is set through
> the mode sysfs attribute. store_modes() does not update fb_info->mode, s=
o
> it is left pointing into the freed list. show_mode(), the attribute's re=
ad
> handler, dereferences the stale fb_info->mode through mode_string(). The
> read is a use-after-free.
>=20
> Clear both pointers before freeing the list. Commit a1f305893074 ("fbcon=
:
> Set fb_display[i]->mode to NULL when the mode is released") added the
> helper fbcon_delete_modelist(). It clears every fb_display[i].mode that
> points into a given list. So far it is called only from the unregister
> path. Call it from store_modes() too, and set fb_info->mode to NULL.
>=20
> Reported-by: syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D81c7c6b52649fd07299d
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/ajjoDhAi2y4ArSlz@dev/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> Added in v2: clear fb_info->mode, which is left dangling by the same fre=
e
> in store_modes(). Sashiko flagged that second pointer while reviewing
> v1 [1].
>=20
> [1] https://lore.kernel.org/all/20260622080749.D7FC61F000E9@smtp.kernel.=
org/
>=20
>   drivers/video/fbdev/core/fbsysfs.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

applied.
Thanks!
Helge
