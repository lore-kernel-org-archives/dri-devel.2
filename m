Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D16ECD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC6610E867;
	Mon, 18 May 2026 14:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="dak2bj2c";
	dkim-atps=neutral
X-Greylist: delayed 349 seconds by postgrey-1.36 at gabe;
 Mon, 18 May 2026 14:08:44 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A8510E867
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779113322; x=1779718122; i=markus.elfring@web.de;
 bh=+ZTH6mJXnH52jDZt/w+tO3h5iamk1G9Jp1Od1dNqBhU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dak2bj2cAaMg4KC4pL/soReYYLx1fvnnbfn1jiReizrM/oO285Dtjy6dxutNP7Qp
 0Saz1YLee5XnfDObAmmrYbR9obnHh27EAcdN3+kNqJMNM7aWby/tMb0WbUkjdoore
 AZVPJqYS96pQraUcOR2npeS7tHd1WoowKEZiergqxA3PlXI7EuTf4al4vDWiptFPj
 stans1ebwGn2fI6gSy1OyJFnaoRdrJVcI5Ez662KJnztNX8Ab14a8ouwXAFhT5Wei
 0104DSD0cA40/cCsj8RPZva5oNfwteu+GPtn/TuyqnEKVFS5yw5SJw+sKdsR/+klg
 PrecHfAuhP7FFTfJ2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1xPMb60o4c-011Dur; Mon, 18
 May 2026 16:02:34 +0200
Message-ID: <49f16fa4-c3cf-4389-bac4-528f8b1a6b56@web.de>
Date: Mon, 18 May 2026 16:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Kees Cook <kees@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Phil Cayton <phil.cayton@intel.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>
References: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bnvf8jTFiXSxK3Zuwh3+csR2VT2XJZVm+o8kJ+t5uPxjlQreixC
 82QRnnF0X8DJ8kjN+5Hrr96x6Zkn6xLpgQKbj0ZSn8WPcsKOzAGKN6NgjKUmlcGNx9N/2+H
 NfOG1Agnhgj6kpvb7SrP52Qwb0008feAmQMBfQS23AZ9APsM9azlSHK0qlu38hXW4op9UZf
 1/ffmdZ/+OhkwJ05J9SNQ==
UI-OutboundReport: notjunk:1;M01:P0:N3gtnVF2KgA=;aXTkTJWM09rbUdrUDN6aSo5Y/lt
 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
 0VoKO2j5zqX7XaQ==
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

=E2=80=A6
> +++ b/lib/io_dmabuf_token.c
> @@ -0,0 +1,272 @@
=E2=80=A6
> +static void io_dmabuf_map_release_work(struct work_struct *work)
> +{
=E2=80=A6
> +	dma_resv_lock(dmabuf->resv, NULL);
> +	token->dev_ops->unmap(token, map);
> +	dma_resv_unlock(dmabuf->resv);
=E2=80=A6

How do you think about to apply another lock guard?

Regards,
Markus
