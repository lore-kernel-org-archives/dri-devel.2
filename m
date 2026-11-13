Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5160A2618
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WR4WRbaq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1257C10E792;
	Fri, 13 Nov 2026 08:49:48 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7FF10E792
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:49:42 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-5058b105df7so199815b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559782; cv=none;
 d=google.com; s=arc-20260327;
 b=Bgg1+vdNg1QFyYz5jMA4nkPM06NVk9YdyiBdAJVV/N6DRtgUnMO6qd5ON3VqU7vaTK
 3xVrz+mk4uXZGOveLMwZ7nmUBqF3QDP5oBXaAygp3m81Jft/qbSw+hm5X5WrBwpXLhWw
 0PFyuO/tbuk0paGA9V0LUTpAXRxN1ty/tG8e6xCHuN+v91u76WRfH3v4cM9Jqp3NI7ge
 rKLkUZgM7AROInFm/BzP7jrUDt0bVPaHI9dIT4M0Msb+HmwILGmfVFKnZRuvo9P0JoUK
 AYDoivptSzykurozH1V5Vom4K57IcKXhS2LiW+wYY1+6IX7lzmDFDpcMR8K/+bBwy2Vf
 MEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
 fh=jRzZCrTRJXgoFYL0/UFnHmKf+LElAtwLsdHBNWOrH5U=;
 b=U8z3t2xI0wLGhnmdyhxJ0+rluc8zrAcALHSSF+6yHArKX6dzXI6s5jjdNzHQy3ARm8
 aqR3L3l3cl268I0arceQrpsXwSxa8NhaS6BwtG8zYXMua2bRcSCdAQwWAd7IV/lg1OpJ
 fItbkI2j8icfPwjmpQZZfw1Of+DB9+KiMPGdhWLS90lAi4rAXZb/OwbCayWAZ2pGMQlr
 OEkJvy66MnzmT9OeQTNadz2V9hAxsKcUnIC0fUPOunZRU+8Cyc301cR8yBTXgGjWkzZE
 4oEn3YBrZZgaW4JZrhEmzjXWSCZwbRdX7faohhJdqbmC8n5swV4iRV45EYjo9p169YsX
 OsUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794559782; x=1795164582; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
 b=WR4WRbaqmMismOg+/HfZeXl3sJIVqFUWfArFCA4aY0VDfai7FAEBhphvzkapP5OgOA
 jonRAxh0SAnUOHlA67OcVYkEa9Vcz/lPW4oLL83gV9+KmP+vcfoxqM4sAMkW1ewU8q9z
 uHJNNiRWOP1JG5+pNfN6V3AqEuyeaO2OR1BhAEEcFp75b0JLEAamytX2s4ur71+XD1ze
 ndh/YGV2NMVuZOBuJFAYIWSgd4HpjMxfFU2dVDU4Mmkmk0KDUqrtQQjb2hJe7/SYNq1e
 FG5oJbxMzi62Y+BGSGpSxZ/na8xgoyovDHc/Vx+x+u5E0c3M+oMHPOsXRY+oX+2SLxTP
 LDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559782; x=1795164582;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
 b=J3Bt+iWTcxSABjin5PO2SO4L8eysG1/JxV3iEsvlW3XwM5NjBJghA7ufwnS9FprKxF
 /cOOSIqWDTsSRZQAnpS+CrH9slETMcdErUtPcHWrj3uyCinAwpwxHs0EJzpklYyXVryH
 ftdnjjMFMACR7+fSS1MPyXGMSpHCksMnNYfDEogQA61d1lqqrJGzuFu1V/RarzQ5JwPP
 uE2yA9qP+eBjsasGGfGlTjgm7/Bibq+V1/ZhF5aJHh/YB+n5JC8AmDaF9FEKq2jW6XsK
 +xMD40c4yPnVgrmmU5LskYNi/0GoypXtd8Kmuc34c79aOC05pvE7uYszEe5vF9nyVSSa
 y9hQ==
X-Gm-Message-State: APuU4Z9+i57eyXgmqWl3rHXPbLhEc0Jj8QVXamccyTxeatxbfy5YkR8l
 JIneAWpOWBnbapzrxOjJdXLFHRCRqbUkY2PY/UOa6qDHiQEK/2O5MKwp4J5Q4DzB3w9qMOzNu0R
 Vnk3ufQnzFVuaPcomBzA1ZD2MfvHHU00=
X-Gm-Gg: AYBFou0H2A/eJgwUblq8RK35kN+q4Y3GvlrTnsP0GF5s8ufe1mz/agGb0NVzYPnk611
 7C4FcEwEBVO5QhuHJeH6ygZYNxhcLaXs0T7zHKT7sqkm778y/3rafPkUV/CN4eUfB5avqahor6D
 PzfQcxMbVcB8yptj6F+1xldHYQNjPfe9kpqiLmM4IaeYkTznianTM2iONIXycgKBsCc52Rf7MWm
 WDoiLsiVdJj/H2TjLUV1P8EzEvDpv0S2u8BTh9Y5Bgk4KHToH7BVABuvQVv3JEp8FuAGhkB92r/
 t7dgfO8Hgll4/qu+3FlhmM2EsM3sl2uN72s7BylJH1e6UIMrn0+DZulqYSavgZ5fT6C/IWs6TA4
 75Xmy6xIIKEFMCa7j40z6CGIhqroSUFrTIzzCHU87dEtkkzOqIxjhTAiGLw40spufz23r0Ko=
X-Received: by 2002:a05:6808:10ce:b0:539:dfe8:9960 with SMTP id
 5614622812f47-56e6625e4d1mr1193940b6e.56.1794559781895; Fri, 13 Nov 2026
 00:49:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
In-Reply-To: <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
From: Toast <swizzguy76@gmail.com>
Date: Fri, 13 Nov 2026 14:19:31 +0530
X-Gm-Features: AclHuK-auqnjQ6e6wO-djNHMxE9adJKmvPX4oU29Wat1ijwytmzWBqiZsfPGJSY
Message-ID: <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dawid.osuchowski@linux.intel.com, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
on top of v7.4-rc1:

- kexec from a 7.0 kernel and from 7.4 with the NPU runtime-suspended:
  both runs hit ATS_ERR during probe, recovery_work was not queued,
  probe failed once with -ETIMEDOUT, and there was no oops
- FLR plus rebind brings the NPU back
- debugfs force_recovery after a successful probe recovers the NPU

I couldn't hit an error IRQ after ivpu_boot() succeeds, so the deferred
recovery in ivpu_pm_enable() isn't covered by this.

Tested-by: Daksh Sahni <swizzguy76@gmail.com>
