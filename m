Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D7C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5FA10F294;
	Tue, 15 Sep 2026 07:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="TeN4q9y4";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4734810E595
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789456349; x=1790061149; i=deller@gmx.de;
 bh=KL3f+0rDXRhmZTOW4GLqNRxK/M1Io/pF854hjNPLPHw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TeN4q9y4pFcjYIxg1NiAzPgUH9tvGQAW6Q4zm55AqTT/kp3FGL66pGWtpwpGWkj6
 x/uU6D0X+JMuQvpOuiZ4MhTmak95xwPUK2pWEczPfSIkKogksFjsfSt7a8NPhHM+y
 CtMRpSPH9iDXo/YNNbAHRMvLiIE34+B/z/hPiC129R8EIA/s+ZWIA84MNy7IFQiaG
 ERWiBiOnzu64BRCQq8kfAIHuC0HMUIuSXDqctMAd7v8mhryRCM8RCeQrQQu6Iu53M
 5RkpAWSQOTjhZP5/hXDHHrQPXoH40QjkVV6VFlQzN74xNZ0KdjRkmpnJkREtMgeqA
 yu5rz6rllAzlnqB6Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1xCR4s3sgg-00HaCt; Tue, 15
 Sep 2026 09:12:29 +0200
Message-ID: <0affbc9f-91a0-4828-aa81-308365094ae6@gmx.de>
Date: Tue, 15 Sep 2026 09:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: acornfb: remove unused code for 26-bit hardware
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Alex Guo <alexguo1023@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>
References: <20260915052038.626258-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260915052038.626258-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SmZkwPl0qvQIvZIIsoRNJmp84AZH1kPf4EYqWTCCPMkJ4pN4Up8
 aBo5yw3Bt3CIDgsiV8kSGBm6t4pGxi/P0kBYt/TzdlF+ih2L11SdPnIUiUhzmU37cioWo5D
 bzMLw1IqqnP7JBhRHG9axYHLgjFpb+JIoGan5YKXoA9CuBrTmcKPcQBA2rsZTbbXFDnKNGp
 n2V47gZo5mdBJqerfVD6g==
UI-OutboundReport: notjunk:1;M01:P0:WFi5RnDbF1Q=;+0BQLTadgfKU5sU45BtiymW6paT
 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
 A=
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

On 9/15/26 07:20, Ethan Nelson-Moore wrote:
> The acornfb driver contains code to support machines with a MEMC chip
> and without IOMD and VIDC20 chips. All 32-bit Acorn hardware has IOMD
> and VIDC20 chips and does not have a MEMC chip.
>=20
> Linux formerly supported 26-bit Acorn computers, but that support was
> removed in commit 99eb8a550dbc ("Remove the arm26 port") because it had
> bitrotted to the extent that it did not even compile.
>=20
> Remove this unused code. Also take the opportunity to remove incorrect
> file paths in the file headers, which are bad style regardless.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   drivers/video/fbdev/acornfb.c | 57 +++++++++--------------------------
>   drivers/video/fbdev/acornfb.h |  8 +----
>   2 files changed, 15 insertions(+), 50 deletions(-)
applied.

Thanks!
Helge
