Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F6CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A377C10F592;
	Tue, 13 Oct 2026 07:53:07 +0000 (UTC)
X-Greylist: delayed 386 seconds by postgrey-1.36 at gabe;
 Mon, 12 Oct 2026 18:23:34 UTC
Received: from mail.frii.com (mail.frii.com [199.45.237.237])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477B410E3D9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:23:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=pQAuZArIzxKdH6O6A/njMg3SSA5HYNDpl2qSD8/d/ck=;
 c=relaxed/relaxed; d=frii.com;
 h=From:Date:Subject:Message-ID:To:Cc:Content-Type:MIME-Version:Reply-To;
 s=dkim; t=1791829027; v=1; x=1794421027;
 b=ZMcclTQlrPLWY44/dPHWEb/lBXO3afcthIbKBhPMOyjhwe1Kn6hTm+WTFH9JzNvH9n6/sOzC
 1I9CVe+2i9qdSzoE1BMpfx0ULCgW91yTL8iFCaU9OZUACLcPdYNn8a5h0QsS+w9Psgd0u5LJrjz
 XPrUvn0MAHmrGSaXaE3bEV4hHeXyrLEDc0ymqxe6OO+v8tbTH0Z9JadffELvi+bBZmjqCypXIbE
 rZ2fUCL1qWSAa1eMFZFr//XVGkDpLGhOAE7T2sdbo3/ZzEa0KKC5oMLGcatE3ad8F9GSaOoqnMr
 XgtPyEVZ+ozqnsXSRg3xM8hJuwR0diIQY1m/Vy3UuJ7pA== 
X-Virus-Scanned: amavis at mail.frii.com
Received: from CORYZ64 (unknown [8.42.79.186])
 by mail.frii.com (Postfix) with ESMTPSA id 4j3QfV6f05zB1bqc
 for <dri-devel@lists.freedesktop.org.>; Mon, 12 Oct 2026 12:17:06 -0600 (MDT)
From: <antonets@frii.com>
To: <dri-devel@lists.freedesktop.org>
Subject: drm/msm eDP problem
Date: Mon, 12 Oct 2026 12:15:54 -0600
Message-ID: <009601dd5a75$e3b92ca0$ab2b85e0$@frii.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0097_01DD5A43.991F31D0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1adX+235cMFrtoQk2cd/Uhm7gh5A==
Content-Language: en-us
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

This is a multipart message in MIME format.

------=_NextPart_000_0097_01DD5A43.991F31D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

HW: QCS6490 custom board, close to RB3Gen2. SW: Ubuntu 24.04.5 kernel
6.8.0-1084.89.

I'm using DRM/MSM with the eDP interface set to maximum debug output.
Everything looks great, with no error messages at all.

However, the screen is blank.

A few details.

On the same hardware modifications with a DSI interface, everything works
flawlessly.

On hardware with an eDP interface running the QCLinux version (DRM/SDE),
everything works (SDE source code is available).

I've spent 5 months trying to find the problem, so far without success.
There's a lot of debugging information, and I didn't include it in this
post. If necessary, I can provide it.

Conclusion: I'm missing some small detail.

An aggravating factor is that I don't have access to the documentation for
HW.

Ultimately, I need advice on which part of DRM might be the problem.

 

Thanks,

Dmitriy Antonets

 

 


------=_NextPart_000_0097_01DD5A43.991F31D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US link=3D"#467886" vlink=3D"#96607D" =
style=3D'word-wrap:break-word'><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN>Hi all,<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN>HW: QCS6490 custom board, close to =
RB3Gen2. SW: Ubuntu 24.04.5 kernel =
6.8.0-1084.89.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>I'm using DRM/MSM with the eDP interface set to maximum debug =
output. Everything looks great, with no error messages at =
all.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN>However, =
the screen is blank.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>A few details.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>On the same hardware modifications with a DSI interface, =
everything works flawlessly.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN>On hardware with an eDP interface =
running the QCLinux version (DRM/SDE), everything works (SDE source code =
is available).<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>I&#8217;ve spent 5 months trying to find the problem, so far =
without success. There&#8217;s a lot of debugging information, and I =
didn&#8217;t include it in this post. If necessary, I can provide =
it.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>Conclusion: I&#8217;m missing some small =
detail.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN>An =
aggravating factor is that I don&#8217;t have access to the =
documentation for HW.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>Ultimately, I need advice on which part of DRM might be the =
problem.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>Thanks,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN>Dmitriy Antonets<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0097_01DD5A43.991F31D0--

