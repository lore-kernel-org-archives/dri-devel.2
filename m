Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13492C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F84410F3B1;
	Thu, 13 Aug 2026 15:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="rXLMD2dr";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFD010F3B1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786635937; x=1787240737; i=deller@gmx.de;
 bh=iQHntodUfi7mO3nLJnN30Ow5eK+ocjWAx4Zl+wKpL4o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rXLMD2drXBYemQkFxKxvDlEVnHdEo9YgiUxfKFS0zZeKySYydM9nBrVfl5PzKkKb
 WT4uFbBtCmY4ukIjyWyPLG0mMlACPYV09LsgAvWZdv0jVo0bDV8JLrxGhSBB+hAUw
 +37xNKIsvpP6onhdogAsMTuelWySOH84+QBf6jxInWstPHoqIwTWLhzEgDrbznFbY
 A/RCNuN3KEe7LBqEtoEGTq+kat+UC6iKbXvAaANSfnmWCsUEXcfTtIGoedoAw9jFf
 RMQ7LDpBfgi+vhRcqJhphE/JFgvQRHSiFjOQGNZET69AzewjKWpAtgbfPhDVuWuOc
 m69Np8JEp3shTjYtEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1wP6Kk3Zzy-00LseR; Thu, 13
 Aug 2026 17:45:36 +0200
Message-ID: <e77b4b42-3467-4c9f-aec8-fda4187f1df1@gmx.de>
Date: Thu, 13 Aug 2026 17:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fbdev: aty128fb: Convert to managed PCI and ioremap
 API
To: oushixiong1025@163.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813125015.1097301-1-oushixiong1025@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LH+pTtrEZALvX7L8SLK6mU37y9AlSI9gvnpShlHrmXznLdAu+ia
 5q0WARf7KpMfwBvqrMq5G7UW971Kl3sR1apqGFDKVCzff/mQdDeCB5Jh7HWjpVyS8NbBKXb
 J1GhB7TEUu8ElsnXnOcWtyPbXx6UnqkfbG+7YLVzZyH74ciEHU/VVuV14NvWmH/dOnbQ6dD
 mQGZVLbyR94GoLimkKTTA==
UI-OutboundReport: notjunk:1;M01:P0:6GKfOXI3Up0=;LXI2UURr1LUNdIHzRfptathtN03
 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
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

On 8/13/26 14:50, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> Fix missing pci_disable_device() in probe and remove.
>=20
> Use pcim_enable_device(), pcim_request_region(), devm_ioremap()
> and devm_ioremap_wc() to replace manual resource management.
> Remove all release_mem_region() and iounmap() calls.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/video/fbdev/aty/aty128fb.c | 40 +++++++++---------------------
>   1 file changed, 12 insertions(+), 28 deletions(-)
Whole series applied to fbdev for-next git tree.

Thanks!
Helge
