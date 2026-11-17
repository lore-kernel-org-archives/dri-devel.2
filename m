Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AE606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WrGIn1mP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4287810F8F2;
	Tue, 17 Nov 2026 19:34:33 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98E110F8F5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:34:24 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b8786bb305so319453a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794944063; cv=none;
 d=google.com; s=arc-20260327;
 b=iO/BXq9TAJDaK71E5/9QbBdnzzoVMUq/U/FbazwfX9m+TdJd9pj0GyuNTl96L3q6IA
 0BbBvuPJK3SYMZCF+EY0VW4AowMOke7MJ9XfKEgm66mnec0zTVjtOx81Tzm9DPjlDYRa
 cZ6S+GnYchkHwz766IraSjYPCLPnNB4tWpvaYrvd/Ak5KvbsA8qxMAa+UJPAxwciwTkU
 SAZU8HPXO8nu84Vly0H9UwSnX2BiFvfOizz7Eh3+SRGJLMvjNo/us9DqJLcv2XvlJNec
 dPg+yP7zdvkxbpoGr2mOZEolZ5QP9p9fSiI5bFOz4DUmcTaCsy1L2bKFJyVVIg4x/qGe
 lCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dCcYu+MhfzOusjYY+ieIbx/VkAkBLtjZgAfX0tGOcSE=;
 fh=91XfB2vTUNN0pJO9w6q/9/fb/yqn6wQVxMkc7RKN7wo=;
 b=k4yQoJONeKqBZ17iSrwZxqLxP5uXl9L4ZMQqd5rtetFyqfB20oXDU+isvlVJ6IUDf5
 poDglayyvOrh67wmLs6EWt7uVgjcTftYABkD2U2WIKRfxtfHBP5/+hPKnO+y4xJVt7hm
 ui93V36JiyhXnlFhj3RN0OATYoXimQo6F7s/Dhmh/F88lMEWeF9H6+gN7kvutbdPm94d
 SCa4J0a79Lfe9oe9FLyEx8AYLxDX4DxV9zDKG2T6pM8xt//X+gJDrAHIRAv43I33jNVc
 tdTDM4dlBfvJRjYYPoZjqguY8Ai93Y7fjBDGM/PAe8FmMJlUxN3FbST/OALTfUcTl87U
 HCIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794944063; x=1795548863; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dCcYu+MhfzOusjYY+ieIbx/VkAkBLtjZgAfX0tGOcSE=;
 b=WrGIn1mPyI5aFFQ3szq133ij2PzdnQ8tGZYdQbI8P7OWylhBWh/pB9YfM9XkcXq+uw
 jjFT9ZKSj5QQsE4mJrW8z4OU/0pY3TtyoXZdgp3JJMg0YeORZogk8lQvn0d+cAdpqDGS
 oIFJtaASdYt1X8ve48i4DCtXTG0yPyffCUl+T0EoZKF3fx9mEDnXZ2Bv+hSqhd27vfgU
 5uyXE5+kmsWkNxxizbnn6gIWVJBrvN2hXOdAnOvnKLf4SxI0gQ6mGcPzH5dZucj09vec
 x3B7CsWIHVB9zh+k0rBoY/k+0a76eg5BVJ5/V722g2owMXA5wmW0eu+oFfbfxmpWFpUQ
 BeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794944063; x=1795548863;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dCcYu+MhfzOusjYY+ieIbx/VkAkBLtjZgAfX0tGOcSE=;
 b=g5riCvtWFqLRmqPuN06i1lIghrjuKNA0XzVjkd5tA+Z6uMd7/QhS05ylBQjw8MT8Vg
 WQrFmgYPIJwGlRtNZou7zLOuiSgOd7kZsO0zVmBVsnla0V0zWZz23rmVb0KaVY2Cuk96
 GfFTdojn5oyUoCDzxgDtIDE3j9KIOXAWIjsd4I6tCd0hcFlZz9oWuCn6QNuhkMzoPM3i
 ARvQee+NaxujY02GahVxJVE8zoR+I5UmnRQuGta8UDuWXnpdh85R5naymNBL/b7GSvzk
 EvDBRdN8f9/zB6AQ9+IZbjzqCcyFcLynsH8Rmv/zFYk1zN/MX9HHynuoqopiQo41rD38
 zihw==
X-Forwarded-Encrypted: i=1;
 AL+hErFTknLb+fhU5gMSRaHOH5K30yfxiQ4AxNwDxy0XBsTq0ecVcFzyz1Hg5KkdRZdACaoiS7bcLdr2PbQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ncGxrHy6+LgxFoKw8QLmRNNTfOlVLs1zn8HsLnhjga3BXVu7Q
 VKcpH5EblO74RQQZxbejwnbbkmtaBht3l0Uxgv5itEa3fow6Pg7e8mBYClyEBKQuajbhy9CWjh9
 oJGVudMWcxYPqNp0FByaDu36FdlU9EaA=
X-Gm-Gg: AYBFou0rSpn8B/N8wKEoVbLID5uLnq1WL9KFjqA5kZ2B6ccaFFPqcQIzjk6ZhxpRQd5
 GMKBO+BXQMfnbsy6UFAK8ChRQqfX7/TBP3U5KqS1jUdU/Xk3vohrmISGlRkFFeg2+Qiiu+bbOCU
 oUesixxhHljJxuzIwRQVmNCFRgApYnJ/5NqlkP5pUx7MhCNrjrxLJodE6kNKHUxl1TCLru57PBS
 E4X++SXNuKleRZnapCLHroWs+Ukmj4AE79Hux9MnEq0pPfwRKGV0zN3qV+sE/gLLdgquw0lsNK0
 9j9a35Cj325qxvmNlqDchLlGhiavmHRRxOy0erOmpZZ2np/5DFz1Yd7gazwU+x+u8zVVUpp8kHB
 80QgNLiFp/qFRY+5Rkqm6+ELS85Tnf+vURXdn4ZVaL2e9goheyzBncQVR8m/B4jWj/N1jFA==
X-Received: by 2002:a05:6402:42cd:b0:6b5:7de8:87cd with SMTP id
 4fb4d7f45d1cf-6b887f1ff61mr210584a12.42.1794944062826; Tue, 17 Nov 2026
 11:34:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
 <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
 <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
 <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
 <CAMeQTsab5H7F5CFvd_XkDndmMiBXRSYBhrMHAf9jynzEqaWp+w@mail.gmail.com>
 <CAPY4CJ4Pq0gXUdGiEp-6srpVUBxYUXPQgOAJr1PJK3SeVn_Rew@mail.gmail.com>
 <CAFGNeahyKxLV1fMp_diNAvXN2JrdRVPt7NRJ5SDuLrfGQ1V3Nw@mail.gmail.com>
In-Reply-To: <CAFGNeahyKxLV1fMp_diNAvXN2JrdRVPt7NRJ5SDuLrfGQ1V3Nw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Tue, 17 Nov 2026 16:34:10 -0300
X-Gm-Features: AclHuK86rQ8SbbaJnlRQZc1dyjzULB9sBoY8tIE5lm1KTesZu4wv8mOkFbAIs6M
Message-ID: <CAFGNeahDm=GM8J=C0hmVBN5HS0thoMJZNVW4srW6WoAFHaxNdQ@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000041ad6b06607dfbde"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000041ad6b06607dfbde
Content-Type: text/plain; charset="UTF-8"

I don't know if it's useful, but I have a way to access the original USSE
decoder from ImgTech SDK 3.5 using a shim with an LDPRELOAD hack

It seems to work with all Series5 versions; you just need the core ID,
revision, and identifier name
This can rebuild a good portion of the USSE instructions; I've included the
SDK (imgtech cdn download) and the shim repository in my provenance.md file

--00000000000041ad6b06607dfbde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I don&#39;t know if it&#39;s useful, but I have a way to =
access the original USSE decoder from ImgTech SDK 3.5 using a shim with an =
LDPRELOAD hack<div dir=3D"auto"><br></div><div dir=3D"auto">It seems to wor=
k with all Series5 versions; you just need the core ID, revision, and ident=
ifier name</div><div dir=3D"auto">This can rebuild a good portion of the US=
SE instructions; I&#39;ve included the SDK (imgtech cdn download) and the s=
him repository in my provenance.md file</div></div>

--00000000000041ad6b06607dfbde--
