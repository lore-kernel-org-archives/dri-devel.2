Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC3606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=S8s8ZeoF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCBA10FBB2;
	Thu, 19 Nov 2026 07:48:41 +0000 (UTC)
X-Greylist: delayed 816 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 16:27:28 UTC
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5BE10E569
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:27:28 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795019246; mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:ijvtTRshIsSLH7QAyyCvvvrO4p6D
 Qt9hNkTP96l/NNEC25lBSI8c+hwODZnF/qMZj0z3xBlZ3GToKzeXG2VQR1SPPJZUDawOCTrNrYx
 WQ3gto4d4YfMkIPG4sDOvEwg1/E5kmFXiFarIHY9BAJr/MG85wy8biPzx/gFIHvwvltXWEySztL
 QuB0EBmoLwnaVgna8CIjim/9BNAiZg1vU/3/+hklwng48Yrt74Bgn5sa/Qth/k4Q9nfclZhfNQX
 mh01v6d0G7T0/OMvUADcUxXRKk5QWHGnmuI2EtCDfYgmVTgxCBL8cA35g8ivzHZlX059lrGgJsW
 HxC5r7+4qiTRSg==;
Message-Instance: m=1; h=sha256: 0004guBwMrFBNGMfAUrywFGsdlYTna2KZ41T+BNppTk=:
 m/bYAf+dZPqaYiTr9U4wbR60qvam9O91KPznC9SM+Rw=, sha512:
 3qyKIl5SuIpMG2yo+ewW/nOmnDpGhsgng6ftgT2fghPcTVp/ymiSHbodRBo8XaigtUo7GS/07VrsF5PBx3DdQQ==:
 zNQth83cxu+7P+zsMCoEGFA85dRG3Im3HA+UQSy2I1SSJBBxQex5ejV+UkYztj2FOXZaJDLzv8zHaeVc4P9ZvA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795019241; x=1795624041; i=markus.elfring@web.de;
 bh=m/bYAf+dZPqaYiTr9U4wbR60qvam9O91KPznC9SM+Rw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=S8s8ZeoFhRl8ku3hO4RVF6uYNL4OfP7B0qu+kxlOIjou8WP37SnF2WBiIqhYr2y5
 vNHjZ2LTU/Rd6A1Rp5FsG684DyEa8fmx9kKtFOl1j+SPZWleqCxu8ge0U59lC4eod
 MwKLMBBFf4ByU/M6mtZ2zjTjhvq7Jn5RU3ekko6jamWMCFQzsCQvDcBcZvEwjZMyy
 stgLRXgAvialce615OnvzLDGCFC43xyiOrgB/IOxtIZ+aV/qhcoVQVzW0efSWFOF9
 5l8trc8tOBH3eT0Nhh+bvaAJCA+Q2I7HQb8l4K6aq66NpfpIvBJPKIfFrfaAB9mC+
 YnIIOzXpeJmdAVsmXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqXS-1x0Vzm49l8-00SiyN; Wed, 18
 Nov 2026 17:12:29 +0100
Message-ID: <bfe10f1f-443e-4286-8172-6f941663c86e@web.de>
Date: Wed, 18 Nov 2026 17:11:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bence Csokas <bence.csokas@arm.com>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Cc: GR-QLogic-Storage-Upstream@marvell.com,
 James.Bottomley@HansenPartnership.com, Jes.Sorensen@gmail.com,
 airlied@gmail.com, andrealmeid@igalia.com, andrew+netdev@lunn.ch,
 andrii@kernel.org, arm-scmi@vger.kernel.org, ast@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, bharathsm@microsoft.com,
 bleung@chromium.org, bpf@vger.kernel.org, brauner@kernel.org,
 cem@kernel.org, christian.koenig@amd.com, chrome-platform@lists.linux.dev,
 cristian.marussi@arm.com, dakr@kernel.org, daniel@iogearbox.net,
 dave@stgolabs.net, davem@davemloft.net, decui@microsoft.com,
 dri-devel@lists.freedesktop.org, dsahern@kernel.org, dvhart@infradead.org,
 eddyz87@gmail.com, edumazet@kernel.org, emil@etsalapatis.com, g@b4.vu,
 gnoack@google.com, groeck@chromium.org, gustavoars@kernel.org,
 haiyangz@microsoft.com, hansg@kernel.org, herbert@gondor.apana.org.au,
 horms@kernel.org, huangjunxian6@hisilicon.com, idosch@nvidia.com,
 ihor.solodrai@linux.dev, intel-gfx@lists.freedesktop.org,
 ipsec@lists.linux.dev, jack@suse.cz, jani.nikula@linux.intel.com,
 jgg@ziepe.ca, jmorris@namei.org, johannes@sipsolutions.net,
 jolsa@kernel.org, joonas.lahtinen@linux.intel.com,
 kalesh-anakkur.purayil@broadcom.com, kees@kernel.org, kuba@kernel.org,
 laurent.pinchart@ideasonboard.com, leon@kernel.org,
 linaro-mm-sig@lists.linaro.org, linkinjeon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-xfs@vger.kernel.org, luiz.dentz@gmail.com, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, marcel@holtmann.org,
 martin.lau@linux.dev, mchehab@kernel.org, memxor@gmail.com, mic@digikod.net,
 mingo@redhat.com, miriam.rachel.korenblit@intel.com, mkp@kernel.org,
 mripard@kernel.org, netdev@vger.kernel.org, nicolas.palix@imag.fr,
 njavali@marvell.com, nouveau@lists.freedesktop.org, pabeni@redhat.com,
 paul@paul-moore.com, pc@manguebit.org, perex@perex.cz, peterz@infradead.org,
 phasta@kernel.org, pkshih@realtek.com, rodrigo.vivi@intel.com,
 ronniesahlberg@gmail.com, samba-technical@lists.samba.org,
 selvin.xavier@broadcom.com, serge@hallyn.com, simona@ffwll.ch,
 song@kernel.org, sprasad@microsoft.com, steffen.klassert@secunet.com,
 sudeep.holla@kernel.org, sumit.semwal@linaro.org, tangchengchang@huawei.com,
 tglx@kernel.org, tiwai@suse.com, tom@talpey.com, tursulin@ursulin.net,
 tzimmermann@suse.de, tzungbi@kernel.org, viro@zeniv.linux.org.uk,
 wei.liu@kernel.org, willemdebruijn.kernel@gmail.com,
 yonghong.song@linux.dev, zack.rusin@broadcom.com
References: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
Subject: Re: [PATCH v4 1/2] coccinelle: Add offsetofend() variant of
 struct_offset()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6EPveX8Ri1t77eUHD87iadI+dVaiRGmKrcwX0pgqshl6eE/PUfu
 U/grdzqZeabqS0kEnnjyRXEVSYDjlvBsjC2oZG3t3rvYXHw3tr9N9kjJJpqOAEsA2vHBJqN
 AR+JHHmlfVSnKcJYWSJp1TR8Y5+Zu/geNXBYWb0YhnSvyDMYofveGe0n8eBYJD9wGvHxA8z
 U1kcbkwxGmL25oJsNUZfg==
UI-OutboundReport: notjunk:1;M01:P0:tYCRkzzKYc8=;S+bbo+8ei1B8QYcNhoJQjx2lvzy
 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
 zpw6FRi5wXlT/A9eNtS8stsX1RVX2Oh7fhTwwka
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E2=80=A6
> +++ b/scripts/coccinelle/api/struct_offsetof.cocci
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use struct_offset() family of macros
> +///
> +// Confidence: High
> +// Options: --no-includes --ignore ./tools/
> +
> +virtual patch

Can further coccicheck operation modes become more interesting here?


> +
> +@offsetof depends on patch@
> +expression ptr, member;
> +@@
> +- offsetof(typeof(*(ptr)), member)
> ++ struct_offset(ptr, member)
> +@offsetofend depends on patch@
> +expression ptr, member;
> +@@
> +- offsetofend(typeof(*(ptr)), member)
> ++ struct_offsetofend(ptr, member)

How do you think about to use the following SmPL rule variant instead?


@replacement depends on patch@
expression pointer, member;
@@
(
-offsetof
+struct_offset
|
-offsetofend
+struct_offsetofend
)(
-typeof(*
-(pointer)
+pointer
-)
 , member
 )


Regards,
Markus
