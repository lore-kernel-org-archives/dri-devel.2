Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8EB606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtyAisH5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6663E10E4AC;
	Mon, 16 Nov 2026 21:50:12 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B8910E4AC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:50:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b7bffb5b8fso5045594a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794865804; cv=none;
 d=google.com; s=arc-20260327;
 b=YiOlE8gGfsNbBsYvkI0PKibkiUZ9Sj3rig1UNj95t70m1AKnEU4j4MIaJXsPY3Bjq7
 ANs8vS6ht510+8CNCweNfP1MtuX4PwuWqbTa9MhlMroCPXLO9Ads8cdjIh4vvGKSMgNB
 vBhHMXuqjlEW08uMFtwHB7Xc5R4rm/zg3ME7PXD3wymsRWLrTLF8WIYXJGM3+DF2OO6T
 8oslrD26FIbOsBzjAqxK1QVzuJnBPuNmJHOGmI2gnlFTj+Hxrf7oZLbFfx6WWhwd9W10
 /sFjx2F0gJGTLbjhL5g1tNEZHLLfJEgRQ0kcc1fWyCrRMXwmtzKHldEv56XbaN1ASWEs
 3uJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rJRV0Ub6rrZ4JdF46CX9umoUrMATSTEOe/htZXEiHsI=;
 fh=VnFTR6txXwjzans0+aPbZtaSbAubDbUbpFe//aN80ow=;
 b=TnIrLy70Wwc1CjsjYKhNiMVT8OUyXUynIQTu0oa50priWj3uXSWvuEY7HOsPGwFRTJ
 9iu8V2rJTsEBmUrDbFS/7ovODr+v3V0fEGoRT42SlZpFFW5iieFW4I+0N4t9a4A8SDE+
 5eNMRvpiCVhJjIqs6F3ho+iphO0pyENgop1tWzv3Em8qV6iQZEK29GHc4znsp3QmSUfa
 oivIfCUa6IWcf7EmiQnUGXg3v/Kate9TZpb8cQJusNuFspVUasQOKn0sPfM0lTiW/CNv
 1X/ZQ3ZDESVTOHlBKx0L8Uvyx7p2jl+mAgUiZgP5CKc2b+IkRQhHZGEvCpjA7UNcE55Q
 8yjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794865804; x=1795470604; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rJRV0Ub6rrZ4JdF46CX9umoUrMATSTEOe/htZXEiHsI=;
 b=JtyAisH5VZ/CpvEoczDLu5uXaTPtuDR4I8whHrCHt1kHOMiVE8IV1Wb9xi0SmVLUYo
 cQm02c/miDXXjlnWe/buAikHi4ZFM4oF2QTZw2FSUpPhDKXfp7HzOr/zoteBmyNm0MTR
 lJDlGDnEtms8MjYgxA18c+JyvY7K3MSkAB0ag0SAbeTeZ+nGOP75Fxd7yzQUhoY8u6ts
 uGXeQU4Cum6gY0zoKchsj5wZny9WsCQb098niupgLT0EosBRU2cCnY1olAnkdrb7N9N2
 wSY5X6x4iml5q51IxEwZPbVGnqcB+sfLB+YVn89YeBYl2ok9cFsE4yFo8u8TMjXoRID+
 XV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865804; x=1795470604;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rJRV0Ub6rrZ4JdF46CX9umoUrMATSTEOe/htZXEiHsI=;
 b=RLjMLkh0TW/JNrVUrSewXQHMQZaufaBGS1juSHWKrUUV4GRN432YpD3rjKFZygOgUQ
 XynJQb3eIRy8iEtsz2JiDt2EL6b56S+cO1ttFtld0f25BqeT1gIQwjftOpageSeGTVyr
 wV7C2i1aI5Ee28Ou0rF+NlIEFHFtPd+6tv2z5uikuP/3+37HpIMZJhLNfyFZi+cN0O9d
 NugMBZIx+oZ/HKQm8+LMswn6y8cAL7Np/iitOPCKN1bTqUpbdFqMtn1k7JbkxHnvpAb/
 hDrI7ZxG+1SOUAGZpz2NvllNk9pfJQ0zcfH52pDufFePwvjwuWZe4L42uSQiZGOFegV5
 oUSw==
X-Forwarded-Encrypted: i=1;
 AL+hErFq0NlQwbJiP2YEksO/MgsL1JHAp5533N71lHZhypCeAVVQcc+X1aodcZ5wip62j/uJrCaTyxaEYIA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9uFRxAZDJe7hAb7rQFIwRsZoH916x0Cy18jgQpCFAktZN2Xj3S
 Sa2O/x1g5zu7Q/DUGkwg3IVkja+0RwqfknnaWa5DWUqZBcSfgeeV7OAcEN0zGkW4C83EeI9sEtw
 a0hdQM0TPTjv5uImzoK0iId+LQx15MDw=
X-Gm-Gg: AYBFou3u4XKSTU7CnkE49VIj3YYeNQ4pmz/5yp6xXmvx58JkSl/xlnnJtPhEPLhrkdb
 iqLEeDp2zghPS3WmUhav+5tUSIAgZ/GSszr0HT5BDujlackg/XL02Z1L7luZ2fZnhNQL67WyCzb
 eu8F/Plazh6Ieb75qjiGV6622+V0bRBG0O339BUCj3tVoPrqUUy9VkshIl+Er4mdvptLxDq1DdA
 T8WvQqcYAXlXdS3IMFuZ5Appu2nkkrVB4MqOfGpX9+E5LyFRIP4jDT/fR/dEvqIwvhmguwoohAd
 zhCHQudZDJnR98ZQZNTWw8g7kbmwlQfZorY0t3FaFGamb5JyQ44/IN1VI/f4qYJf0ucxWZ5Jznb
 A15hdhJOYDlToMZyXp8J72HWnpAI0PRsIH/3NtGAM1KQfMzxImTxAaz/XdGgrcSv2vUQ=
X-Received: by 2002:a05:6402:2b87:b0:6b5:8695:f839 with SMTP id
 4fb4d7f45d1cf-6b7c0d24fdfmr9668541a12.45.1794865803505; Mon, 16 Nov 2026
 13:50:03 -0800 (PST)
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
In-Reply-To: <CAPY4CJ4Pq0gXUdGiEp-6srpVUBxYUXPQgOAJr1PJK3SeVn_Rew@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 16 Nov 2026 18:49:51 -0300
X-Gm-Features: AclHuK95X3dIeI8uNU2mmuDdUvNrztj82on_MQyLnBbJwwze9azNulqy_WyxtyQ
Message-ID: <CAFGNeahyKxLV1fMp_diNAvXN2JrdRVPt7NRJ5SDuLrfGQ1V3Nw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a3334c06606bc212"
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

--000000000000a3334c06606bc212
Content-Type: text/plain; charset="UTF-8"

That's a good idea. It could also put some pressure on Imagination
Technologies to release the Series5 documentation

--000000000000a3334c06606bc212
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><p>That&#39;s a good idea. It could also put some pressure on Imagination Technologies to release the Series5 documentation</p></div>

--000000000000a3334c06606bc212--
