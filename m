Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aUF94i+O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568B310E054;
	Fri, 23 Oct 2026 23:37:49 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4237010E054
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:37:43 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so1644415a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792798663; x=1793403463;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iS0JVD+4MBOlIwUianlhvazrunPmJQvwkktgIZspJ6U=;
 b=rZ0obnl9skZUd7iNtJzoLe2JhjuNvpUlI+JgOxoUX6zqMxorzsw1CsxK8JUePnuvmb
 qK1zFlB5qEcF8Kf2UgYTmcg7/+hSyKfJgVPYzykN1ph6av7rKmAM5mn8PY+b6+70pl84
 9SKmrH1RNSxmGzjnpCz3pxhCM3nw7bNGah8s36+9gDCTFinDnEUs+lg7aW8hQqMziImc
 dFgS8rY+3+pOPckfUPonqomloA8pR04Du7JW/G2Aryz32j0Be4Ewy8hcqzhfDN1oRkqb
 PM52lqoLJbay9GLhDyNMrB6S5XxJ3uB/6UMn+XzmuUQnDBQOGof4p/nb5UreqjrgJLsz
 D1OA==
X-Gm-Message-State: AFq9FYJRe6cdZvoTNqU6fplj5cxwFVh833D6JPM6rX6oy6GM1dRrXcN8
 BrAycNenYGjyAJPcIwslZwkTeE7nFvjJRYIU7KVjt5e0Q03FrxjTQfOO0/JyT64PPuldL2K2F27
 H05DCn6IhoX/M/6j2Cw7FDKE6g1fShM4QPfeZU9aMSwUKe9TxWcvEYu6P/1ynITQHcJj7Gpp3Gv
 ku3fj2oztItLtyowfyXhW//joO5Z5p6hqyKE7f3ZshS8BHv9zyfIKARys+NyJqf4xd5K6wkNmOV
 zff2URXvJjgm6UErpCDHv0LfHJb
X-Gm-Gg: AYBFou2s2hl+xIluvcbBSuOEF6EpoMLFOQRKSRKthpBf29OTC2vkb/DrEa+NuMs7ArT
 HfzSSPyBifLBSRWoRu3eRxqrEX/PIxWI4tDhhxM4+MhuFyRNWJNO3ynkCoYcmyTT7NA4psZRZYn
 xGQ5ZHdEILBtE5RAFsprJzSdaNqgnITx74+Keb7mlM8OymcUwHvw/RbxOccifF2oV829d1BOq+P
 Vs9w/2gP3NM2aHCGpBNrBh0Ao1dcvfk7JtiKd6Lfx/CLLOFKNHIQolrn+TdXtAbcTmyaUlxbDW4
 sckXFBz6J0Vd8o80J82RK8p+V+bk8Z5FXXoOSnd8XilSCKrF8inlVuxd+7YSCDx/OjknivNqAOO
 cJaLkg91TwBzvqYdCZf2VISVKGGm+U5mZR2V3dKklZjk9dfZlBk4ABTDl7Tor4bzWD++sR1/Ttu
 h/CfyJGI9j6ToGCqkTZnWSAX2LHv9ElLDkSahMsdK/
X-Received: by 2002:a17:90b:254c:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3adeae6dc53mr589183a91.46.1792798662703; 
 Fri, 23 Oct 2026 16:37:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3adeb83b073sm235977a91.0.2026.10.23.16.37.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 16:37:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ce7a85f04so281597085a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792798661; x=1793403461;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iS0JVD+4MBOlIwUianlhvazrunPmJQvwkktgIZspJ6U=;
 b=aUF94i+OTJ5KqbjHcUviNVDdW4bwSEPns04JNUCW98oemrKflRZFwYBz9NJmNySIdV
 A2X7BHWl4N0yvu345++Ypem+FUhX78V0y5BBrTCSFxu7AZ9IiRh4NwV5VCtV7vQ8/xpr
 OzC8EBic52KI3ncmofcuOda1jJ9pOH6r4+T2A=
X-Received: by 2002:a05:620a:4441:b0:93e:e1fd:b87f with SMTP id
 af79cd13be357-940ef9c9453mr86401585a.83.1792798661332; 
 Fri, 23 Oct 2026 16:37:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:93e:e1fd:b87f with SMTP id
 af79cd13be357-940ef9c9453mr86399185a.83.1792798660844; 
 Fri, 23 Oct 2026 16:37:40 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f066a5bcsm37558085a.13.2026.10.23.16.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 16:37:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 16:39:02 -0700
Message-Id: <DMCM449DWDHV.1U5UYOS65HWUW@broadcom.com>
To: "fausten" <yunfeng.li.nb@gmail.com>, "Zack Rusin" <zack.rusin@broadcom.com>
Cc: <dri-devel@lists.freedesktop.org>, <bcm-kernel-feedback-list@broadcom.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <e84774ae-b49d-4df5-923d-ae2cde480aaf@broadcom.com>
 <20261023090121.5031-1-fausten@ebizmis.com>
In-Reply-To: <20261023090121.5031-1-fausten@ebizmis.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi fausten,

Sorry for not following up on this patch, I did not get time to do so.
Will get back to it shortly.

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

