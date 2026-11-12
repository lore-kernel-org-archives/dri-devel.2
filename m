Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtWYJURk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51184112071;
	Thu, 12 Nov 2026 12:08:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45E7112071
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:08:02 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso40887115e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 04:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794485281; x=1795090081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6cilRW3ZdvvEqyOAsHI47MoyEeVw10tLvIN3xZrhn8=;
 b=JtWYJURk3USAKzjFtORqYEuONMUlU2TjuVocnXuOwaxeonDXRFUoTBp3TWEXIt6wvz
 XB9HFmp941prr+4QQqwjlGIfUqej8ZasqaMuQ1DT82fCZtv/xUJZB3SIIo1W8JaxgI5Q
 +iP7IZ4sjWYHrwcmC3flrpvJ7sZUHpLW9YJNoCL+cJI+ejmtRw3OTqxYW3Fso4HQRsbL
 zcLvPoexQpE+aGZdPn1jSJpSMpwo9HKSqDgnmZi9apbLfXLsfdkw2/LuGuFzLxrgHsCK
 26SQjsFBnIR3z+u08k0pJQ2/ziypRNvs9tI1c1MJrWzXVlP8sncelf9hK2zD2WSFmMD8
 DbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485281; x=1795090081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6cilRW3ZdvvEqyOAsHI47MoyEeVw10tLvIN3xZrhn8=;
 b=cwXfKLWqGSg3JiQlsJf1GkKH7W8NGCmnEfK7Mj+z3cB9WvqMa4o/eaAgm1ZFXugsYN
 wyNnAsL5MuTV3wgUQLQnAZIJ2RddjBojIFFNakYmJjOyaPwQ7ukZ6t2hIR54ZhdhowNR
 YtEdjNYpxaE54MrL9M0YjSUDKBeJWNReelHcpTUUlHxWFtXfLwjv6CyimwUxPJiEBuaD
 5hYexISA5eQXMIQ/tRsFNWvtxztCsE02ysgGXrp9BffscznhlcZWtoOshAa/z47LuZxw
 fzb3LBgPYq/NogvG9IX55/K/swv3AafxqhzKyTnqrTJ6WFIDU5EKFSE5mu+4xDDHYCyl
 5ZNg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmIqUOXYPx+03oadscnOrekkBY0eskkH4Cl6dTg3tPCHO1UTUiuuVFKeAXaqFritHVqrU/+HGeo0Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qTOoljsj0pssWe6j2ChW5P4RTmGwCW132ho25ST4abD2uqsVW
 A0uA35eKftUYJF/iiqDgxlIRkyWS4rX+TVzY8DA6HpLPg7QZpg/PjR5N
X-Gm-Gg: AYBFou10BohOv5MX8guC7lzVX9vlwv8X7cWkU60lelODcEDXVScNJ4rRnO53u9/GfaO
 pRWOo5OyTioOpijjN03huLrM5b35LT2UMONrfEmsppU0GBryB8UluckGMn/jNeIO7J3+ugIJRAd
 BSw5nHpRQjWZKXjpw/AeESbGhh3Eq9MpEg/7AbQ4EygRd6y+lAPLSB3SEWGx30erjjWQ4pU6XfK
 V97ANPwwhGVHfMcsucjHf/yz49BuhGu7TZsebbUPangB6rcm11xaRH64L9iM8URHZeFA3aU4IgT
 hZPnin0kpXS0LsiGtQHftFiyVORiTLn6tXWC0Ljsy1uLEU8A/ZWIeyVGbVWK5ywn0RCpfTRLOMJ
 0RwzZINfAE/FiItYRXIysqJ3v5leUR9muxB1IjHPO45crOqEmQRJJJk5+J65iFHufDTJ9piH3Pl
 0cME/CNSZDBEiCCUibTPIkyeDJESJhtGPqeWxnnyXfsH816kloaOHCJBkICo6FyTd9EODShSds7
 2zTx3ncKLGYW1tfe7ode5X7t4jFW8tit1O7iF4gWjyUyFDhhRb1jMsDMHAVH6M/LoEEBGtySEi6
 DioN9va3V3KALu3IfBDywPHdhXX0ELnMsQ==
X-Received: by 2002:a05:600c:4e41:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ba0931ed76mr98707145e9.2.1794485281186; 
 Thu, 12 Nov 2026 04:08:01 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2776casm96342905e9.14.2026.11.12.04.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:08:00 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 02/12] vkms: properly compute gamma LUT size in
 vkms_atomic_check()
Date: Thu, 12 Nov 2026 12:07:55 +0000
Message-ID: <20261112120755.1478018-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106201813.129911-3-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-3-leandro.ribeiro@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Once the Fixes: tag and the drm/ prefix are in place:

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
