Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C11075275
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834A610E914;
	Thu, 19 Mar 2026 08:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="GCOEOBZZ";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5321C10E911
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773909335; x=1774514135; i=deller@gmx.de;
 bh=yl/XbtjEnCkJBfEMd3IdtFsnv9FiquRUTOdivXWG4Ws=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GCOEOBZZAZGMNtpSajsRPZDaPULi9MFIFAlq+VoKZZF0UoABjMApGgV7/Ps+W/cj
 6ZzNggIwAPLKWCSPbGYwQ9UIV826qrSv4tD9bIBVDWTTmYBN198BWMBi5ANI4c2L5
 79nmvOqChhlgrkk4ERTiBsEvOFJAqNEJ4p6EfO+xVUYs3f8/O99Xw6JzMHzMrutEv
 cJvdm23sGYPP0vGTccBArVuYEc0C7JdU2uTDbDb+FFnQe6xFJ6we1LCzYcsy/Fqao
 EcEoW8oALlbGi6a1oaaxYiJXKCqjMVOJdl+MT8P8xSJmUYLR5TyrkybEdg5Bs3GJg
 81PVY1EAEzTg8ekwUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1wEkTw3y6I-00XBgM; Thu, 19
 Mar 2026 09:35:35 +0100
Message-ID: <c717b7b6-ffb6-47f9-b345-de0eddcfe7a4@gmx.de>
Date: Thu, 19 Mar 2026 09:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org> <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
 <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
 <abuyJDK6E2aHA4rC@ashevche-desk.local>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <abuyJDK6E2aHA4rC@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qm90Z3UrDbDD2ga9kl8s+AornRk5hoo5VV4tCJKTVUktS5UdAq0
 WNsYKnMcmTYzqHb0sHYf5D7l93cSY77UeW4ltT3XdUdwyfpCU/k5qRqS1/tpGCymQSSeuVs
 xdsovjKMTXypY16ouafCImLzMU9SzCmqoiAk4FpPYacR1YDaRaAZfWXlau+29D0qKkvTOSa
 jKfuBs9QgRe28QEuXB6Vg==
UI-OutboundReport: notjunk:1;M01:P0:oyMVoAL1XaE=;0IH2gM7dwGmECkRxyzF3QjH8KoC
 5btCWnVDWVzziTEIhrY7x6lWDyYt9womNAPPzkWD9Q7yA6hgK6nhrHxdK19kevVfuy8ao2Hcg
 tU58y4OHaQmDh6biNgOytLZxA41O+mD31DVN9jXwaaBv7U2+Ccv/m4QJJ9kCI6TGMhZHHZGIf
 W16LJ0/lutHl/BJBRtZ/luw4D2hTYQ1Tx1ARf8bMzU5beLMiyONDOmmZGbWIe2A1ET/+LvlsI
 RFLVW+R/ecJWw/01oIKP10tljOBXZbMrXOjC5rAY9ithSz1LrMcu3rNn9bcMJflRqYsYVXv/z
 d1HrInTEJd/eej5QfqcUhpt+Dmcsu01jFFcIak+ZemllSwgukS/glUQc41eMEMFb6yZTPp4VJ
 XRS0z4xpGLVVwBoaUt/Fpp+v8KVeFF6+sST4SiopyBKY/epkgLhYxyHJKwYhUvJGUF2BqZqdM
 b9nLodKzCG2UcAc1D8FLXLuCL5AIQmY110joDWs6CefZwsyFB88M46YzIQw9Y5gJue88yfiIH
 3Fa4IfQJ0+8Ho8FtZ+IvAalULdzgAnK/rY6qRq64gR/DaQE059PHALQVPnruSJBNk8XeFn+Is
 MjaAGih127sH7ToHkDH9hQs+EahMSAvdvOosx49NE3+jYa2v+oJY7FNYIw91FVTFNjF265gzZ
 2mUevDAVEDSVgHboTtuBGv2WUO/HrpYlFIj3avGVio8vPuysOGKRqx2aByOhtG26Pg8uLCpSz
 QrHkeCKJffRVqQasUvPCpLC0cULW7Wsh5GRSr+TQC8B1kLcHjSiieAoqFesQo+F+fT6e3rY1p
 +ZJo/zX+EvHBTP7eNojGReps/lXCWWYQeZclVWQDHbVtYqWlJXSv/8W7yh8ii0aCSe1S4NM7b
 Sfd3XhiAQAckKJxmGEcgV9De5S7OPfwPfWzcvZ/w0K/Btu4f9u25UJZH1MguucMPCVRa0Bdyn
 s3T5E2hReOfm9ZqfSnclOxfpqypWJ8DLlc2pY3vb/Au2nB1heMMxkc5y6JUEwoiuA+46h56VK
 LWDbN5yCjNX/c6k/YymxoEZ/2lQ1QFjn/2JjoSZ6HRCnwjNjRcVMZ3Ec1jiv+ZsWj49wRyc/i
 BvwgNWH8b8jgqUOI6dcOKbmo9Pg2zbzLwryJnfJddG2cWWTbfQWdPD3hIhEv3WozuXl9UCtc7
 1ZGqxEjZms7ncyS9J2wZAjoOzRGCgNEgSe5eRgyQF42v3bvq9MAnHXrUHmAW2fE73z9KKzO7O
 o1cjBZmyTg30eihFGbPoQV0/fUYh36gaytC+wA7a6AHFIfr72WimzvbNBXpFkKXacoM/qqj1i
 2wzoNk5FwoSOhbsD608WJ4AqDKilTbfAV0EIj/H/twMuKq+jcInhwOz9Rybt3bnS4oiZbXIM+
 s6owVpAydIZrJydrHCRobzmWuFulqRqM+4LMX0xtMwicIfANq3g/LVHjHmNs8ALahV+LMJ/E/
 /6nmv/dFTNg0PYhkkjd+/jOzRsugyU6KMjkaqAWssmX7rnfpnl4i+7OH4g5SBRTW5HsleXInW
 mz7C6Xm50Pn3RRnDTmiJDVJANBRjW042nqmHHEXhZYsq/fjLET+C7oVtxDP1u0qk698lreaxx
 D28slB/HNKQAW2sdZ47MZ/d0xNU1O0nInktOBZQSy07S+yDNoHLxlP5jRfdPj5YdQLwPOXzJQ
 SRSh+dxJYLtebncd+qC5IYspk3LXPfPwLAQjnQqMBtYY/BKtzJiFkP+rtrIsOGWSMHJXPPPks
 9Z6LrDrVeKahhbaUxQsA8P1S3her2+PlJyXs9LgqQ88cml8kZT9O8Gm+c/TUn77UDs5Q0ooNP
 QmIy5jMl5/l5YPjBFXCdPT47SA76oFLgTJGSJPbANuCy1e5/QV67FK3sJRWPgO6k6fY6VT6uA
 tlPnCCTjSKPc9sipij/soYZYwxIdgxRLmGiaberd4F5iTMc2obavBZTJmDqwpDV8KeqtXTu2w
 L+fr2wnhXSiyJEe8GffSbyFJYgrNYPQ6wFKnRGeRAhKLMBFTP2paBGjx+HKILRUbD5rZOKjkB
 vRpWTxvvrX6RI80rSqKst7k+QYXNvmI9cISeblgLKQPvqRyu9hHso+1LL7zBJQrTPn/hp581m
 f0YZNtcjbrhZtlsnBW0F/heiNJhGZkapLd8EEfRPdsZHAa3NNCdCNEal2plXreRjWeCnfUsDa
 XKyjv09yjE+9HuBil9rPB8ISYodesOwJIG+cYfTs6VHeSr3ejiH+00HPKzv5C4CgJMMMRLESG
 pAOhgo7ww+hoc8rvWdXARiSlIX/u5yCjkuklEYOM+DO+NJIyOEb/7tdTj0e4ycaT42FvzFDXW
 GF0TA3gLsOx8/mbq2VhxM3zNzJq6S9oa94qWSpiy/X1zvE/hsyr/DaNDdLJUBd6FJNU6uH774
 lmmLO/VLTzJuqEUtBtSsNpmcX5FR3H53YO8mpslGG8om+PiHdUGxI37pNLfa09J2aNN56B4wj
 4aIpQ5GFaK1T/XuOsbBx/vyXplRuSar/phQhJ0jugV/Q9U+3OnVg0ve6NNoMQpCFac426RsmM
 xFFzpCOfjxrot4L6VNcNbSYzeUtVO6pZTHUTnMHMV10J9FpMCA0fjgkeYKC6yTm6Z3weVuGV5
 /LdUxIyZ66+FmUg2k1GVU5T/z21Il9keaA+P9cRajryd0EiR2GsVRmgqh+X8fDHU/atb45teT
 lqPMuQ6LY4vz0rrsqEw7jjRNR+HEBHydJLIKnbSJKha1sdyVz8MTXrw+LOHJQY6RHHWg63Zdk
 HXZKTnDm+OVqDXNU1P+cQtIytl+iSimSFwuCawE+Xay5v9Yw1iQKl4b1OeK3ozXED6t/AqjjH
 NMSulEwUSq6RB8bGLGun4GM88GjOIcRd7A0MNbHO8/bvM9Ace1ijsZbITkpyjXaRI+HDjyGBD
 kNDtti1Ag3pUJyJIO/rrrVIvSko7H9ES1ZxlRyDjmLNc9ovUBwTVhtxAnHm/gJ+FXFxGTJ+OD
 r39wfFMOjzVjrDqePttSUFA21WNAoU3prLwl6TJJN3/MUgbekcMkMDQwe+P2Ke19EwM5aiFfg
 I32PCEG/68JTS4Ado5z95lGNayo5Iu3siTjkQ/bc+bga1v5cLwrJ3hBraJnBZT1Lzg3VgBH74
 1jq8SWWCiioFi2ICZkF1l97l4OGC65QL3ZCNv6xpeRtZM6qyxCBVb92ylo7bErOLT4rijckUa
 KRKHY1hqcfFOv5u9JAWEBqiDf28m/RCinvJKchc9ondaMVhF+LnCFwflpfsn2rZxrn9wwoE97
 SL+tqb1A4rhiqyO52F5blpigcYg4MenZ+lbwTeIC+U8bB8us+8WFCpJWBLEUfkEea09odbmdY
 qYYK+xytV0aKOUGgVPaVd2KSBk+uSU1k/tatMgTm98JlGiihTKT++oVvop62svXHvmz86Vpd7
 /lnN8qTPq3jOVFZNqmSsBn6JXoxiwyYVxiVizqfBjLqNFeoh2EJsSQJPx/+1xyojkWcCAvwm+
 KIbUvqWzF8ghkf1jbTdOmZ6Uk9PAVjHakonXZhLSQNmFW80vRNyBrepBgqcnCB6+plAhh4ekv
 UjV/qmJj8Jsaag0gFPQjsIjsNtjGMkq72SN3+ozIobA0R/Hpzs6K+C7e90TuljL72PNPP4dsr
 peJ02DClwB5P3SYLRDLUYLkcRTxaPJcKpvd8njJdafjMICyODvGdZ+TDS46QFxuRauZJFKmIr
 /hn37n9AufHxIAbWYMiNySZwKkrpdX2FIM8kh4/aHIHzTEbuLAFZiqZKwlamf84N1R8cIxsHc
 +BDAe5KYepOJQ2tJ63qqj+fpnVP+BLPq6U/a/eRE97MF/OfYeLWURV4ShQKjSZ/JLf1Je4rHh
 J16MgGhwm64qAaT2XIDzObdSaE8ztS/3Yv5O4QhKdbwbYKHOWheGj5B0a5DVeGoQxbmRrr31H
 OXoyLuThxPDEBRQZMdW+xhoUXslOQY4qpKDEL5wK4G2EvxB1vXqF8ZmKk0z1oxp05jtmuFu07
 x6q/Nf1pdanhtq8lUTHxhB4geDqAO9Xh8OBZfySfphzQ1ALi/mir2/BvD/HT7YabiFM7DrTMz
 yMPYgwJLi0apZNTf1glSIC4SNrWlb6nroYCAWG3i4uWCo+nNH8xRCOuU7kxQZEMtOMifFLdIl
 fdtCmDQtwa8/IXXk225EaeDYOiCTGd1KkVlHgRk7cmngQBzwfHgKILlWLubi4+ee8U4qq2mOY
 JSRRWK78JejudkKkSJ9an4BWu1D4iyYuZQ+GSr04w3h24D+wME8iFBjhnnYdLCb/993E0PkTd
 vVnSwyv75rthS1578EiAyY/a0opyYepEgFeCGycomDd3eM/6Gwj6f12N6oea/gESsFJI5OBHc
 9pw6jCdwirZIYGlW9zCsfc7kegA+Bqdb2ocSBvJ1j8P1sabxvIVaPvzHieX0aW0/mXzW4nagt
 AfEsnniP27oP1gcyUR3v7roXssZTwbxRek+zcZwXgpPlYfrJtfz4PRdGuej/ro7QIDcXP4E9c
 YtWj0NFC6A+EUwfoA2rGEDY89W5boLwM/dGGIQsICaRh+dGC+YqEpXgLRnDpTDHupx53vqoqQ
 c2y/q6Xpi8B52LgvqUNFL+lhklX/x5xkRNwFCjB0xaWXkogE+dCC/i6SsoBzjvtqhuRtpsnXl
 HLRnM/Zu8DIHZ1YQ4WDdyoL6IDjCYRCKmhQyC0XUSksF0TJSC4/ig4NRJLLjKCQWXZRx7bLPf
 y2kkUetRRuwU3YsnelewpY9HgwL3S0tA6yUl/uofc7PeTloJBCtGwgjDzzdPWGcsb8wSP34HD
 HWl6BzeEp4BLg3j+55si48Cn+6N3+yRs4Lg9+OWmHbvlmxpKj8p0WfGgzw6xkUYxvrg+w0ET9
 ELAbenMyZbtwYEjq21Tut7cKJpykg5W5cadYDkcwyB9bHvUrr85Dy3V8XhsASGCXJW3I0ggVw
 cCNIaCks67vN19VAgwc0cU+SIbHft7hzUJzs3PL1j4z4hcan7pPJ7u3MUNJf10a8JrSpDLSVC
 U37m9Dot+jBDT3SywRIYMNHR5aT94touZsHteACNkTvjjPVkF8Go3zoqrPmWJ4Z2kZb3xYz51
 Awg0hZrLSdPE3BTA8cCLn8bNjZbBx5iyXKwmzHuMgI9bCdOicmtSVp9Xbh5D+OlOAWpOTOnRc
 dZQzyrjEQsUlHu8k/9WvQD9lKJj46OzS445LxeSvYAS7eJLJXZVWuFKpYyYqST7xrGYYFR7qU
 G7zAyjTgLgBg1fjQhKNOFcpnOZ05WAl/tbw8C/nzgVyosWGe8Ak6DVma7NCSY1dp2VBGPb/GY
 m2ZjgLGJIBtILL0gChM25YSoM4pxJSJ01ivXWFyjkA==
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

Hi Andy,

On 3/19/26 09:21, Andy Shevchenko wrote:
> On Thu, Mar 19, 2026 at 04:06:44PM +0800, Jason Yan wrote:
>> =E5=9C=A8 2026/3/19 15:38, Andy Shevchenko =E5=86=99=E9=81=93:
>>> On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
>>>> =E5=9C=A8 2026/3/18 15:45, Andy Shevchenko =E5=86=99=E9=81=93:
>>>>> On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
>>>>>> On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
>>>>>>> Fix the following gcc warning:
>>>>>>>
>>>>>>> drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
>>>>>>> =E2=80=98pixel_vco=E2=80=99 set but not used [-Wunused-but-set-var=
iable]
>>>>>>>      unsigned int pixel_vco;
>>>>>>>                   ^~~~~~~~~
>>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>>>>>
>>>>>> Thanks, committed and pushed to drm-misc-next.
>>>>>> The fix will show up in upstream kernel at the next
>>>>>> merge window.
>>>>>
>>>>> The most of the patches from so called Hulk Robot appeared to be con=
troversial.
>>>>>
>>>>> First of all, even so called "dead code" may have side effects on th=
e registers
>>>>> in HW which may lead to other issues. Second, the mentioned dead cod=
e elimination
>>>>> patch doesn't improve anything as now the dead code is 'mnp' variabl=
e (that's how
>>>>> I got into that, I still have a build error).
>>>>
>>>> Sorry, I do not understand what side effects this may cause. Would yo=
u
>>>> please explain it in detail?
>>>
>>> Any IO (and specifically on PCI bus) may have side effects. If the rem=
oved code
>>> did some HW accesses (especially reads), it affects the state of HW. Y=
ou can
>>> read more about PCI bus and what read from it does.
>>
>> No, the removed code did not do any IO and will not affect the state of=
 HW.
>=20
> Excellent, but it leaves the code that does IO and now still breaks the
> compilation.
>=20
>>> Helge, can we revert this change and start over, please? (I can also s=
end
>>> revert if you think it's a better way)

Andy, all points you make against removing relevant code is absolutely rig=
ht.

But for this specific commit 7b987887f97b ("video: fbdev: matroxfb: remove=
 dead code and
set but not used variable") I have to agree with Jason, that the patch is =
ok.
I don't see any build errors either.

Are we mixing up things here maybe?

Helge
