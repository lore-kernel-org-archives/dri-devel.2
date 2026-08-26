Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B61EC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C6310ED94;
	Wed, 26 Aug 2026 17:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="t8h+pkH7";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AE410ED94
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787763617; x=1788368417; i=markus.elfring@web.de;
 bh=RIboMSTk0n75LOidtDXp+0aJmxZ5809SXh3wEQLUEVw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t8h+pkH7PgqaYDZYFI5SApGWxY0HCkSNHTF1UWcgyR+RSvPXwL3bzvXoWUR7mRNT
 YXkkj6Z/ghZNUtmZNPfdnXN/e83yPhz+bMemkfUjX/CFyEaDE8dJPYi3JoJY7UQ4Z
 BYh3fVkbM6OQCOjM0K8XsN/khzQHBcfQH4DqyouVskwfpNMmhybD+/yuMpfj1fSO+
 u2Z+ph4/5frcTPxZc8gA4Ajg9oOarfb4T9y6BK0GRQMApTrdz804lQbP355Xa5fRY
 93KBwuZkuduMEM46eGfW4eRfXppL5iikbFLdM7H71eoYIxFLHgp+u9EK6s8snFHXS
 DebfyP4YTkESQBIPRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1xCDHF2YBF-00H2UG; Wed, 26
 Aug 2026 19:00:16 +0200
Message-ID: <0d6bb2d4-5f6b-4fd6-9b9f-5f5f0f687625@web.de>
Date: Wed, 26 Aug 2026 19:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 llvm@lists.linux.dev, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bill Wendling <morbo@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Oded Gabbay
 <ogabbay@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6jOP/lI1Ra5far4mgM9KTH4mvwnSgFP6QW6ZdjBSvuF6bHxgwjL
 pZB8Rx/0lYq7VNsG+Tg+MYcrE0FXO3QyKoQ3Ccc8rdTpfyoD1batg86gMmAYa/Cw3/1zYHn
 IDs6vojxDfmdzvIf8xyd5xpg3AqTPeqanhIrwFIM0pYe50PJgGUIHmBGGxldX3/ydENKyNu
 udx+pNQW30rbT+n3QT/GA==
UI-OutboundReport: notjunk:1;M01:P0:ifj0B9Xdpjw=;HK1VqLd3h57EG5ErrUGya6d+KqK
 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
 QJJbDTbhZC7C1aXSM6LH5iIyZ7Hr51Sz
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
> +++ b/drivers/accel/qda/qda_memory_manager.c
=E2=80=A6
> +int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr=
,
> +				     struct drm_file *file_priv)
> +{
=E2=80=A6
> +	current_pid =3D qda_priv->pid;
> 	+
> +	mutex_lock(&mem_mgr->process_assignment_lock);
=E2=80=A6
> +unlock_and_return:
> +	mutex_unlock(&mem_mgr->process_assignment_lock);
> +
> +	return ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&mem_mgr->process_assignment_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.2/source/include/linux/mutex.h#L253

Regards,
Markus
