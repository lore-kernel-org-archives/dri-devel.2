Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC660A380D
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0HmoPaT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F3110E265;
	Mon,  9 Nov 2026 16:55:47 +0000 (UTC)
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3ED10E6AD
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:55:41 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so531698b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794243341; x=1794848141; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mhYIqd6kntPK5D0yp8ryiSLq5VGJ1a18DOD+oetciCw=;
 b=v0HmoPaTVCpDVyMZmcuwaPWGNx9bhm5VPPYcjAOI40Nu8RuGPUtOWUfIPf+H3AFfiB
 etVrbS+Y1cI4Y8tbQg/YBxKpJYXUfzSfa1S8uQzhuj2lRxFbPJu8DyrFKUty4QImAeG/
 S0YnZ1fbw/P4bMeAPk2AIdxign6JAS7hUpxDwecLOQrN1nnPbM0E1mzkwiokUToypWwf
 6qhJzzm+UdnHPPV3BFD0pEJs51KaYaGL3weHQ+3XkQ+zaY1sF8CCohxrHT1Ao6+MolwQ
 k1dviX7BI3ZWEuQyBv78zZmLaGCkNOy/oSpER8lNLC/754N+HzgKYsF/AwTfVpjZc/36
 JzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243341; x=1794848141;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mhYIqd6kntPK5D0yp8ryiSLq5VGJ1a18DOD+oetciCw=;
 b=wwTk+9rSKgq5tUzGakEYQYWwUzrE8T2V1Ev30U3Svh82RnAoBRkGoY9gTpaYhtIxBg
 GyTpMg35wsd2O+7/IVnSbHmOWws4sElXNLtwwBNnf2wr76bbKDTETkRdMRDEd7iAU74H
 JY4ITN3KsX30jahmeW1KRfNGrYgamq+oUBN1stAIuUq//EZjPtdl5beuqxSaQ+owmPqu
 B9jZgCq/2PJarkM11f0FNtUO9Xa7T+CiIdUegvIbm8BfA2wFSdOFAeF4qA4kjvjVaNg9
 3VvEmRYu9WDFOCxmYxdQYAof64pF5BzBid/f9eCfDU7QiJaaIR6BRIQGT8fkQd++iERk
 bWWg==
X-Forwarded-Encrypted: i=1;
 AL+hErEc0uqVGDDfPCmQMGZG+3PZGNZyPji4+yH2kQn498cLsPctgNwOLv+QXfm1F1uI38WElQrm+4jz73o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9QYislIqIlLb2if2kafDgNw8AMutLPSDRwn96w/w+7GpSz7+nm
 i1yWm97HJq+woqLRadyt6tenldhPTyIfsLdIaMMOVcGh9RQjCTuzgNRX
X-Gm-Gg: AYBFou0vTo/6RniaNaImnopQ+oPZZLxFAhO2eBUsGwMrnlCokAfM6tSi1FGEDmdSBXM
 mSPuL/NR4Tl3xCUrBN34JetBGcBCfZcOkcQY99y28ncDfy6xOBo4syxkswuKmIwpI8tF4zd2W+B
 Mbl0XVTtbPd/qidtapDpDjwlwH4Vv6EgmGON1Tven14vOPELXS8V7cx6VUwofLpFakYxbrLOfQ1
 hHKNQOtu4U6hSgug1aUR8tMfS0p0/7Q3ILSF15LMrEF6kAbDj7Ds6BFCnsR+1NeUCPlDdpbgPyX
 cetOHpWPd0ZtIoAOJ7cscBFq+RUURVZQ6XAl0H9noIQ6WSnHmHt0MCPayAzhpbkznSQ43AGc+lv
 Jf6L/+1yMMu9KAaOGbNi4JyrZ7Nb8gAdVKVdoWgNKjxsVeWpvQXkyZxriyXFa+ZFeL3Abiy7ZzK
 GT6OXGM1yV4uGBwS9TODSdhI0f9HOctzus5vpd/yFo5Pd3WNpQ+/n2e4nS3GlVbjRyxwoyOfLZ3
 opndjWKCnYTFsdwXTSzPlMmIstY/3JiZpLm2bkP83L21qOFnIYAIHtQ37jkBcuc4hqZdK/Mhaap
 /HM73IZhcp8inqQ9WXHu0y539X2b4t7yE87yS55r3c5pYEonUm9WPnhduSNG2SrFyz4QYx15ooS
 1IGLwo8MBVDgkrARZP7+3AxMRS6SApVcH
X-Received: by 2002:a05:6a00:1402:b0:8b9:a5ee:cf05 with SMTP id
 d2e1a72fcca58-8ba97ab7f9cmr1152b3a.17.1794243341050; 
 Mon, 09 Nov 2026 08:55:41 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b648e54ddesm1624865b3a.10.2026.11.09.08.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:55:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 03/22] drm/amdgpu: implement SVM attribute tree and
 helper functions
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 03:54:43 +1100
Message-Id: <179424328378.201169.1999994927528686770.b4-reply@b4>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <d6275052-1715-4066-9291-4f4cce9c017a@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-4-ray.huang@amd.com>
 <d6275052-1715-4066-9291-4f4cce9c017a@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On Mon, 09 Nov 2026 13:41:48 +0100 Christian König wrote:

> I think this whole block of functions can be static, but not 100% sure.
>
> If they are used outside of this C file please add kerneldoc for them.

Several of them are used by other SVM files, so maybe those can't be static.
amdgpu_svm_attr_find_locked() seems to be the exception, since I only
see it used in this file. And yes, they should have kerneldoc, ideally
with the locking requirements.

> Writing that I added Aveline on CC, it would be really cool if you
> could take a look as well.

Thanks for adding :) I have some comments on 08/22, 10/22 and 11/22
and will reply on those patches. Sadly I don't have a setup to test
this on a GPU, so any testing would be very welcome :)

Thanks,
Aveline Noir
