Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D964AC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C16010F144;
	Thu, 20 Aug 2026 17:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WnwyBU8I";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FBB10F144
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787247105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KRvUWZDGEUMSwtdyPJQ/5FEouBX9ts8IqZ+F2bFuJWM=;
 b=WnwyBU8IDy4hmrBz74p+LLnYIMQgd8BJu6pVHEWXxpH3I5sImIOCeRjmX8hJqIHVxL6FFi
 vbfTE4eYN4HBr1BLZRX9oSZxUDFXv0ze57nvI7U/59OEsEwSNPIkbkdqvZ7K8l6FxprNsg
 QSiGmbnY4TuI2Goe5VJKEleX5KtucX4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-47YWyrwiPuqQOIsglQb6YQ-1; Thu, 20 Aug 2026 13:31:37 -0400
X-MC-Unique: 47YWyrwiPuqQOIsglQb6YQ-1
X-Mimecast-MFC-AGG-ID: 47YWyrwiPuqQOIsglQb6YQ_1787247097
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d33c89a29so647601cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787247097; x=1787851897;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KRvUWZDGEUMSwtdyPJQ/5FEouBX9ts8IqZ+F2bFuJWM=;
 b=i0S+518IV/pIVnFsvE49x4WcNObR1GU2N75ZE9SbmFt37yGyZ8Wa+/ku0l8UQSTLQD
 3yHzGoXWK27jOHzsRi0DP+wowdSYu56M1L5yGMyJWofVicvZXj5aCDj6bwiehMkRy3z8
 Tn/yNk/tZcS8hpxoHvFeajUN8KA6ouuUYdNO0JiTJMfSAg+WYtCAUhmuIbvUti7bFTqW
 i2+XXS9RLbg6i5sLdA8jicr/wtdJq9d4z/5Vypo0e2uqoSq6Ky2GRYKUiMSBGEcz1+f2
 Up50aZEXQg52eqwb/vtAfuPkxTaZWooleoCNlxbXP3lK2pkzto8NqWmwz/UpizdPRNdd
 mbKw==
X-Gm-Message-State: AOJu0Yw+nQWzxNWG3RDlvz0f8Qs3UDVziQ8fsoQyeXeNo0bQVk3GMnkJ
 XHrJnOAyso44LBpPEaVyo375Tfwl/McRAq1MacV2t4RRSNhuF/FBZmXvwadq5OM1TiJClZXEHSP
 a3jYbzsuiQqVHt8JdNEJ48ZUh/W2Asl7scSEvMKEAqobNUze8OEQg3Kd28u76p6X7a1aYAg==
X-Gm-Gg: AR+sD13TzGCQ/3DZraIOe+B+4uJnHKkAeFxWAT48E7OYgGV7eVHHMQ/K/e/81rcZM5e
 HyaX5/v78ol8QaAKEL8Dxzzktr+cUZWj+zLDuTsDo3iE1ADHa7NvQ20EIRQxKMYkK7f4ZBDZ6Ch
 IISbaAw20vXU413I0m+eTY9IExBjwHcWNc5niwLwPYe5fL65pQHTIXz2k2mbm5o8inC3P2t5rWK
 ZxqXRsTGtabmpYkg13nCbOUB7k0YTx7ckzZogBVSjaBsOa/7wkZRrS3DWIOmYzVEGI+Md5GtjqF
 JeRbpj4vS4uAkM6lwEiXRlwPJoqcI6D/oJIdjjoSa/+1AbZufwZLoTf8yETGY8+yuxhITGe3
X-Received: by 2002:a05:622a:514e:b0:52d:ce1e:cd47 with SMTP id
 d75a77b69052e-52dd5783cfbmr148948801cf.9.1787247097142; 
 Thu, 20 Aug 2026 10:31:37 -0700 (PDT)
X-Received: by 2002:a05:622a:514e:b0:52d:ce1e:cd47 with SMTP id
 d75a77b69052e-52dd5783cfbmr148947671cf.9.1787247096457; 
 Thu, 20 Aug 2026 10:31:36 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b5a1bsm43204606d6.45.2026.08.20.10.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 10:31:34 -0700 (PDT)
Message-ID: <bab55a285432b1b96a74760146963b29f5c7d7cb.camel@redhat.com>
Subject: Re: [PATCH v2 6/6] drm/nouveau/kms/nv50-: Obliterate
 nouveau_encoder->crtc
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Thu, 20 Aug 2026 13:31:33 -0400
In-Reply-To: <20260819160841.31C9E1F000E9@smtp.kernel.org>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-7-lyude@redhat.com>
 <20260819160841.31C9E1F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZ4bkGk0JpOBqqJjZ786PU1nYOk2qbPjas02lV-HluI_1787247097
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 2026-08-19 at 16:08 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Pre-existing issues:
> - [High] Encoder atomic disable callback calls a sleeping function,
> violating atomic context rules.
> --

Again - another hallucination. It keeps seeing the word atomic and then
recognizes it as being a word mostly around contexts where prior
reviewers have pointed out sleeping wasn't allowed in said contexts.
Nothing it is commenting on is actually atomic.

