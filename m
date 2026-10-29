Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C713606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=V4Qa2C2z;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1KRXhNcE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F3610E775;
	Thu, 29 Oct 2026 17:18:49 +0000 (UTC)
X-Greylist: delayed 1683 seconds by postgrey-1.36 at gabe;
 Thu, 29 Oct 2026 14:15:15 UTC
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com
 [148.163.139.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA1C11232F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:15:15 +0000 (UTC)
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TDG8gf1814028
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pps01; bh=LzaYibF6mNyyGAG
 yvN+zjBCsoGvCNikDa8hZ39a+8Fg=; b=V4Qa2C2zvxI3eZn1CBiQ0Ki/7SJ/rXC
 +FHqNzyzDmtqMKO4cHIn0n2+7gF3bShIaqq4UJg6lWju5GBFofRf/DN/tdKfRsfg
 6f8pj+9LH53i3uNQB28bX0qBkPcie3eH4T7Zyj7hPrX86B0BQ6LnnDuHGH6wtEyO
 2x786dSnO8t5JhTkO/xHfX5c1QWWnG03iVtBEgaoTlycvp7WostUlnM2iavifmLe
 nYniVw9Ae88PnAC8Hu1rhfScswKvZxmrV9e/rcIfqiRTTWGfT4EjD+3gPFcjc6gT
 g/lIa88ZR9GUnxKhiV90B9BqIJ0biH1ZbaolFXuDbNza9PrEBNDvOKg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hkqah54by-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:47:11 -0400 (EDT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988bbb0ed9aso1789667241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1793281631; x=1793886431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LzaYibF6mNyyGAGyvN+zjBCsoGvCNikDa8hZ39a+8Fg=;
 b=1KRXhNcEPVuh/oPXCOQACcyrRAKafXTji1YiusaPe/qLI7IZ/2vE1JiKaXrq8C3OIb
 Q+vS9MqNFF0CKYdMOhuB+FLozjKHLDGppwMECrUuah9JYT8m3zqonvQh0eJwMPWt1EIh
 WrPc+TtXw6GdlmdOu/eWMwjZ7pi7eB3JYanY0zIRcp7amosBT0JSPO8i6hbG9JyTUA51
 SOYZR7iLlWrr8Kpt00ZbsaY4EdAulBHURbbNyEw7zbm/Z4/XBOieKS1rdDWRJuxERJf/
 9daXtRzsAyjGJacXYc1nQ2O2jPocvXSva28FIiQohDe2SQ63wlrDlbPDW490KnVwu287
 d2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281631; x=1793886431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LzaYibF6mNyyGAGyvN+zjBCsoGvCNikDa8hZ39a+8Fg=;
 b=neFg4zYCFdD0BcpJ9NokrLYanbGHp44Q/RVlveb6ixtJlyqpIus83/ixQJjn5C7ETM
 VYh8SSaWCwpuo29hik3QsXY/kUL/eu41y5j5//ygtLc5l5bAQcXqztaNCzCmKSf2u6lA
 wThrxEzkAGtXTWvfSwufURhxh/+wUSOyUewIJ9VehzocUzCWx/fC+9gCNhtN7eYJis20
 HQAdhgkHICWpEogiZFMK7Q5DzHAT9Nqgdc8NByRGAtCm2uCwoTnnnX7JMuBLob1uNL+f
 jRE8ELK+Mr3UaY2cxH+zIFfU1WoLtycMMmrGIH4YCp/8uISR7uZtQ9EZW1AD7iieesxq
 j9HA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZd5jtzYtt58E9afg8kqtPyvirMQGwFpP1H4euyeD7h8BnNVfjDpZSphFG2POhncqzu1puOIW6gUY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFi6KD6cr7UvMxBLIP8MSTCuKHaGpEjOdtd0AUvOzIC6t3UNyU
 cmH+/sAyCQ3Db7mOGJCXvnhlvbmqjPNF8ryq6+gCnt9XYUvqFO2psWsWTy0DN6OeBsee/Dz6acs
 Qq0XzVQLcZCxjj60AurXwnUk5+Y3YB9KMVaqG5J5XaSvWEw9pEq/S4nhmsEoDVVX/wA==
X-Gm-Gg: AYBFou3o+NGFMcx09YWWYSYOR0t2pLgL1g8sEp4iMuk0dMdh9se6jKKOpE52et2Wq8w
 TCHkNPyhBffyy2dVQXRONUSDXseH/qV+sABzWmQNI7YQ3xHZNwTTwb+pDAydLYjvyjnEZoT4vJX
 GEL0IlFoZSUXhyIjng+Sa2+UEm75qDa5MbHePPab0nL/Vd/K8rZuwwgFfWDMtSriHsjnNy/ojx8
 sUAoMz8WXHNN6b+pSJdEkuJXENS9xcagY2K6KjpIlJUi6S3VZZKI5QuFeCeYPTiRVXQLFm33Cgf
 joqzIzMdRXWTAgRb2Up9VPfTW5HpeKaJL9yboucOGfZ9v28yaau+6zYeT40B5BHdUEV7UiGnkwY
 bzOnGU2f2uIKwNQ/Yux9oMqQEVFa1lUv61h9plWipLB3NrczelUuO3ixKSWqs8t7UvbtUFn/Aoj
 m9EVU/2YrbozI2SY7DN5Xx5Wad6AOY
X-Received: by 2002:a05:6102:3ca6:b0:7cc:2086:34e0 with SMTP id
 ada2fe7eead31-7d03a1faee0mr2882892137.4.1793281631263; 
 Thu, 29 Oct 2026 06:47:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3ca6:b0:7cc:2086:34e0 with SMTP id
 ada2fe7eead31-7d03a1faee0mr2882865137.4.1793281630591; 
 Thu, 29 Oct 2026 06:47:10 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-179-7-133.red.bezeqint.net.
 [79.179.7.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33431146f8f.14.2026.10.29.06.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:09 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
To: Hongfu Li <hongfu.li@linux.dev>, Hongfu Li <lihongfu@kylinos.cn>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, kees@kernel.org, tzimmermann@suse.de,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH] drm/i915/userptr: Convert page APIs to folio equivalents
 in put_pages
Date: Thu, 29 Oct 2026 09:46:05 -0400
Message-Id: <20261029134605.882933-1-tz2294@columbia.edu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260723064651.4100-1-hongfu.li@linux.dev>
References: <20260723064651.4100-1-hongfu.li@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nu31b5bsl49hmizDOXNxrs4ZQzY5fpwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX2ZZ7SX2ksVDI
 q99Eo9xnGVexiNpkrtsWtgfra/ZctvFxvmPRLnMH5aCHwZ2E6LoGyekoyBMC4xSOHlg3vyAumpL
 /S4YbKX9fXIoBDYSGuzrwc0nDq8vlq89b+34bDuG7Nff0bSKXAmu3Nt1SBvl1kGXfcNOGv+5cUH
 Ly4iN5oHXHqZ2Zy3yUqWYEsBpLk6fD2jVtLVyfL7cDbZCn7aGDJRjCmwBMoqFNTLR/Cavvn4/dW
 AwmMXwl6mDEENhNyYAHLBgyHdCJstKvx7RUNSWQ61pdkdQWNwCGtX04VXmGuLbOazWx80yes00A
 enUxHv2MtOvRaE2X1u6N859ihPxJm3U5WQYQAJQ1yMtN+NYmR7o3vODMY9teTjIdzfA5HbDjbyX
 DMOACJkPlvf8kvYDea6zrIG6ZhUhFS0bsctQ4aeutHhjycmc6upaqhp6nIwkiQg4srIWZeN7HCo
 Qx+xHsTwB2fwRUl1uJQ==
X-Authority-Analysis: v=2.4 cv=X/nHu2Te c=1 sm=1 tr=0 ts=6ae34e5f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=bg3mo46-JBcyr3_gL6MA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX5OrrAsyPdfR6
 AzvmCt0RnlbAQifOMHdc10qs2arSjwjUw2hStwEdvQJNzrN5K+MLdYbBJfRzSo57nieFWNdAmu3
 ob6a7BGavnP1AmzQ9LYrzOLmcN+8yiLUb+bvQORU7eCYIfXdzh10
X-Proofpoint-ORIG-GUID: Nu31b5bsl49hmizDOXNxrs4ZQzY5fpwO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=10 phishscore=0 spamscore=0 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Jul 23, 2026 at 02:46:51PM +0800, Hongfu Li wrote:
> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> Cache the folio with page_folio() at the start of the sg_table loop,
> then use folio helpers directly to eliminate repeated compound_head()
> lookups inside page API wrappers.
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>

Hi,

Is there any update on picking this up? It would be great to get this
in, as it removes the last user of trylock_page() in the tree.

Thanks,
Tal
