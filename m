Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DEAC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231B710E647;
	Mon, 17 Aug 2026 06:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="WZ/QZS6D";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDB010E647
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786948101; x=1787552901; i=markus.elfring@web.de;
 bh=sbmd7hHup//wXEXvt7HizuXg4aizx7FkRF0NQWAUaLs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WZ/QZS6D+OYv1KjoQwPsZNunyykXy8rlPstDerVDfpN8OsR6/OEs1NLwQkz4v5Fe
 7Z1iF8zp5ldKR3ofiUzzpl3eCsrJzMZ7nhQ+6MJJ2LG6u3hxlGbK99o2iH2yLIZn7
 I/eGowN1pqP86OxVI4m5TrJE6BMKMzi1FXPI/dO7URirpqFVXZ4Jz+Ur59/yYlQ6l
 KwtKtx+RCEk8xd3oDPJ6WWUbYOjs2OUZiSfjPolFpAde5Mf7dFRh98vDGprAkPw9+
 igMOn9y3t08jcuCQWKw5VCC9I7wXJCPTCFyeauVJ/ZaSE5ANpdTN7k7QzVODnmX46
 MQFoVhiydKqvEb4vVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1xRFlT1fBm-00KLP0; Mon, 17
 Aug 2026 08:28:21 +0200
Message-ID: <672fbb47-7836-4a02-97e6-30ccf53b9e97@web.de>
Date: Mon, 17 Aug 2026 08:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yuebingkun@kylinos.cn, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260817055625.276500-1-yuebingkun@kylinos.cn>
Subject: Re: [PATCH] fbdev: platinumfb: add error checking for ioremap calls
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817055625.276500-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9PbHmOMtHZEHk8Nfin7EHmni4ZfjkzAfKnsMSoLi340W6v32E0
 C2J7pGSWXJDusztq7wf6Uyrf7w5VZbmqRBk1UMaEafPiCU+2RxYLdth4R5M95X3h7G09Aif
 hHOadaTyhFJOHakwt6ro+iOoTJ6jKkgGav7wuVopMvWGhzPkCxavc0hfXS14ULTVOuCXliM
 pm97lRt6+orK8zYystjHA==
UI-OutboundReport: notjunk:1;M01:P0:CiSKlY/MWT0=;apmhAC8ewegoHlVLKgG+3NACNWY
 nvdOFHGe3CQgjtk6YXYoPmGc2wKF/5yV9JF4kusA+dN7agWS6iQtXQmtwCaYWNx3W3ZRZkNNn
 t4w1MkccMD8BSgEK124jsl23SWLWBzUFgZZtWIHQgjXMRwXr7kNifwjwgfFb7+O3UOZVau7rj
 XzPuMEtzilpIfDjFrhMcLi1YXIlAKh0dLKRTPlmdc6cJ0UXtJE0+yhWrK+axVkKg91Iwgk93L
 AdA2ULiMMFA+kf1SrpNtHU9PO6fBRQ/ZEFxwy138vP020uvDvK3NJgdHgVxq0Kt4CgoRXivfm
 g/RocP3voKeu3oXAXL7jGgr4uxqA82AF7gxxrfmmp42UAXXicUa7LmjegaLVdWWNBgHd4dLGf
 qfXY5FlJlU2NWKKfLdZOdKHsTG6rZYZf6DWRzsQsagEU0ff+bqU9NnHgHJZjEAA7g8VsQwjjD
 wZsv82s/z9iBvVEVu6sdjxmqYD+rjPoEcn4kV4bc8LlUef+tZVqcUXmwpmLI6WZq21RuqkQNp
 8eClEZfK51K7hPnZfmxHTJDVnf1CO+5/SdCwajYNqTHYunaI/SHNvTIFMc4vdiikg/QwEsbcq
 uNhnfQtgm3ci9w8Uq7z2Jr7c1hUOBflHRebPtBNEPj5H5Xg46qZEfEPmkpQK/U8KiztmtM+cn
 vceipcxMxOTCUjUXcYdYUS/ybK4bWfv8gWyke1YEcV1CMPTjhM97Kj5e4OIem8JXOHcsJ2Fe6
 4cIUsccJm7B6FZWvpctrhkCKV6BDS6pu8sEkoBPvkPU4va1atiw0zCHaEZ0KYKjHqs9/5PEXf
 uo3zmJiDxj2wUrYJFX6KNencExJh5ufdslYDUmA0LgExaGI2IQEX1142riG3Z+D/o6FH3vWrS
 stK2D+I43JmKvPy+9DvY740a4EWJ7rmC/dct07rBPLvC/BFxWSAtV4KGsAPjHaP1KvHIdZhVi
 +eeCK102kqQ53foh+yUWq1L5TUCLXHPSqEIg+4nW02lGDfSTKoeyrOprS0ryrouBDWF0VOnMN
 aeTnekKZ2EjPl/MvoWLYPGDCXEx5T4JS0vXfgi+XxpLYpNVYNfkJ5XBSrwQJxPb3hN8VOx616
 7s22kC9A2JZAGqqMFWgDW+dwbPHeosJZ1iOkglLAzWY6gUrK5J+MVj7kosGI8WNUL5aIXEHm8
 AuDunLReTKK2P1XsiPDAPOKESVALEjcN9eplJjbpVCWefrdiCnx5YRRh93sAalR+IEY/ORThF
 cfUgtbIpit0eVg8CdRns5jnfLx4kc2wQ11tDOZqXSB6g6jsOFXj5unofSCKi9SYQTyQsRhP3u
 Vo+XjkAympFxQLeh05lyqVUsyLvYgDefoYlnjHcmR6GErOJPkAthvG8Qeu60aI9rvXEOmcTol
 3+VCJymp+Iht4mLYNNQQM7/MMD71uPak2u8XYtar/g379nR9ozuXt3j/1EN9bemcwIgxOb6Yn
 J9RMZEaCR1agvQTmxXftCII14XB1EpDYZsnZjPhpcJa7ncjA9Dk3KtyUqOlN3DP1zT4h4G3xk
 ChyNNJLXmx8dhl6PRWX1cg7xWRCUlsteIfmEuUILpys9L05cpH3H4yBH4lxNjIe0YPLFuqNDV
 3pP6cSnsg0bY9/2e+CnnJQMiCGzErhG+a67ir7dViZbnkQm3QU4Ye5kytOXxsxhbXwTWWPerX
 yakY43Wyxk7/0aB3hjlfs54P5iOjS+x81bKxgqQcUcaXdVVtfEa4qHtjGVHOXIK4hp9E6dh1y
 SdXAfbhmEtqodHyHHnsA0jAqGDBezvIIi1m1ghj9NQJ9ajzbU142/kajrae7rKYy7c7arVGMt
 WSVX7SYf1fA/NoLyQo9nCH8ciS4hsd43T2gJ73sEqiT7+80+YVmYzlBXSHGQDQZN5H/9rhMBw
 JqWfIVmUr9CQ5j4/L1qE+NtDDXQExn6h0PtwABNz7vteyBhdPxK3b0tP16S2xRjPwxRKhjIAq
 wOI4WOwbWu+/NBxyqn462zai0c3WB2/2S0Fsffb/qWfiFb8iBAjc+aVgmpLCf3F92zUdwjIWh
 LqbzpO6nk8aMQ7oDv8Q35FKXVsrFDxDO2rxCY5R+auVnbJ086zIUQL4oTLKhmxaUaqEI4T4V2
 ++VrnCzAW6TTQ8lC5rJ7KPF1lgarTYRCcmwfF1jm582agRJSs/LNm3PcsjZNjvHzktn2HjLkt
 m3SRlCditiAsSHfZJMMHjnjzjy6SvAeoP0nvt77RsNVLJ/UGu1e85tGKiSaHCF5E4j7Dxqq4E
 qo80ImHqZVB8kn53SOO+l2kMftt4QBBncW0NHNGC6GQWxTwtk8svuoORd6hlTivHrw6XNd7c+
 GHkH107qHzNyHI4x9Ke9k9jIfASkMI9/JggF3yqH27IJTiaON63SndltREVEb9Xlx12H1rRLF
 61mSsO6jTY2Caz5Vyq4SZOikUiKnYpcAaX+uKDqhNRxvfzNmVo1LyoCDioZlxJoo0dTTSumO6
 Z0yp/URhgfGU42KYLa6fM0rzEDyWysWYMb8ST4qKkqXoWmH3ZM+4mbcdf+cElxONoY5t4TIhG
 sQuUvYqiBJtIte/zy+JZDXJnkquW7AO4lthFYhkX39RlSACawLFUXLfAz+C3moBxkdqnJibHy
 yOG7CIzm7mFrXLbfSOmltG3gcaANHRqhClrkppG9tbLeWKafn1lE/ew9nMrkcq+y5Wi1Cc5b8
 zCA02IzJ238auPPxbwl3nvjXmmV7ec5nAm7KUkyaQHDrfyFo8oEtbCw0hultIrut7QykP8n25
 by2Ls4bfwRvFWeOqz5NORPOeky6t+GyVL1XWds8+9Yx5l3ubhReXwxiAqWhWL20gNRIyBFrYo
 9HY29Ux/RFDZSJ9UUvfBcYInOZxfzn+PZlx3pF+CQaa2qhhyEbjOBkor6VlOfQWhT35KJ1Lv5
 my4mW46oy6qfXaq92ZqSH2mqiQKt48ZuX4m0ciZ7lKrVzQ7iPv0XM7QbLlWSVGOiB2+WGoX2H
 lAg/oya68d7l+mwaGW/qU24fLQKlYLP6YgeXpSd0Vtc4s3qc8dNY4cFz2kNhgciNwCRBUTK1i
 54Ok5ClQWjofzGPIpUUy5pU0MHSYYh8ExuAUEWhrpY3vDWk1pp6o1l+GPECXFTDajf8zk3G83
 oY4+5zGWHAXh2Di0XcGI/itdQO1LnCwCVkY38+5x5uRb+J7Lfd0/WUJSt4zR+UZ206mPyMvby
 flDl7KfsA1dqpRtzXBVla9obmCbXFbfJU+eG658bNabPSAVUXreRUWcBIfk31hGtTrVI1m/q4
 rlSJXk00W6UEGDtgZfD6gy+EgOmqoAkUxx4FU1JAXoOwXD2H7ojOxLGfuW/mvrW7RBgK6a43x
 Zb7DN96208QHF9Skc7JU2ajfQZwSvplND7pdIBZnkLvZPDHxufE0gRRufim9Tv3ta7FxeXAfm
 G3/73j6pccrk6UZHUt8oxh7tcy3A/j39UyV7CPJR+Hww9B20+K5TwqrQIBrYrhbTWKMXJtrEq
 azr5Qe8XyQW8bf++euSg28DUHnWhy+7E0U7kNaFAoW8oI/lT4Cj1K8bnO8n3m9TSNPalxbwQh
 TPzMl1sjCK+n6BmWGNos5M2yRupWfVAuiUJuK57SmWaBtj3NawahQLIAguXw1L7+N0aWhEo+F
 OYKoTbV9he3g/chcH5atpikL/jx7wvX6dUnscuHx9z6OIEOm8f02/mE11onqILfuuN6RTKuZh
 9Z4wi7HGVVwqNgn35rmCiJdV5KHrikEbXcFUQUcuNN88AusMM6HxVQStvPdjx1aPo97Cavuw3
 d4ybzNwnljkmrDrclsBuMUEvUCONeIye/Wd+SRQbG2vUytWBuTEWrS2bStmXPJRQG5WugVY06
 DVfregXB3FNsgEPJr3un/0Kt8jDUEoz4WyqUMeXYxXQmHDvoENnq36aDjzbp/Un5NoOpX29MU
 xgfp6Tmq5fHj3eNmGz7aLdNHGIUNbWwhNYbEmAqrJjcpcDkRCBm8ZW1ObtcHlUYYU24tjUWxU
 AM8MFIJCnY9wWbsg39L/YHAAThOlWOgUV+EJM0N6er5udr0UPs5KK5P4gOXRNlIv9sxllDpQZ
 Ky3IEstZ4lSAo2U6NldgpHHMkGyDpMkE3OO2DkMu5m2/UDQmks+vrjMEFVlefDqs2YG5L01V5
 DOwQuMnUV+RH2wEEMaQ3ZIaXKkc2azo9MyFrI6gKUEOgjuOpvRKREZRbxHc+BjJdvXuGUovGU
 268lTylNL/U0o2LyDT2CGIQWnQGHxpjkihi4a9htqziY4FCklJt977KtcpQc4TPHcmk5n/3bX
 z9NtAKjQpJFN/oaERWArfKZZpJsAUFdWglecFcFDTKmhloRb4zUDwnbJ4MpHwycV+OSLYKXoD
 SMP/cRTZ7QsnyEDk1IBcgKds1k3IRF0CUOT9OSOJF/hXQnxXpCnzAaKynoaJs2XGrpgyar4gm
 H86adjP65Bqgb4ac1MCJNiosrLozWPNJU7joTI9S3QkQyLXUzByrTN/quGtREj0bHv/MGIBLw
 9F07zqaxJ2RWmWblrFME9xKgES8N25NO1cvTiSCTcxL544n3Y+tCL7rS1uRuO9l/JwQE7Mhqn
 r7UwvYH4qIz8w7S/l16iMIcVh8PBtkOX8OD75dDKZTLAftqgl8LlWbxlGJdJ0Z5aqcM4UckJz
 eqQMu0jKTaHYTyXMsLOmk+GWQeicgddUk8XWhjk5v5AbPZxHd64WOBrZvVGF2po4DEdJIr+cj
 EoogCE5WUMoRKEZ+N8GjjVxb5toxnik3GGkfAPVijrRtIMiZVMqUW4maJU/NxRJi9SCVYz2VD
 k9mG1eMhdF7IunO8QC7COso3V4uCvo15v0LihBeyE7HD0vpza34JQZWGbWX0ikyzFENdicdg2
 0UxADZFdXJXkYADW7kgpyv3Dm6ylFXsnA1x7iVC3ITcngk5ocX9hxacWySXTwkaXN0OAqhKNN
 83/81ehrA+WJuqA1iZwnWEQG5Zlqup9lPR4TbRHOYQb7wlyPTCWoeIERYBzpDKTQA+MVV4Ww6
 NwGeETpnZlds/bRwX2G2lctw4BPpDEGuFcsiHHvvKYOub76NryIOvTorXkrQX+8/A/j/7i0FQ
 5KuP3OkDIOD5iV6MqBxZFxw2bW0kacDlkMt0BtYEbxxdYli2Fu5by5vwFsEJMwX5mFOeCZ1eS
 yFsOO+PISSkLGgGZcl0PG5lULrH2ooJjI08BQMga5eLNZQuJdyWMlIN1eorTOf3RYRnd8oM6e
 yyyoSTFqtZCeNLI711us6Jd9S5ATZeDW3fle4BgICWTPpJLHIgxmvHbF268QxvBSJbXAIp1gj
 At+eHbel2XnPqAcj1cvlbDgnvmDGIdcMzaBUrtNSwZX2N2JbbtzAH0XvLNttsl7jAxqGobj8k
 evUh40WiLy1Ogq12LrdIk9M0Wg7JpWcn2YT832JVz8gtw69ekw7TzwjS79u9+5xwTGD5tuBsh
 ayDpUW06eQ3BORdLvmh5/HaEGOagodoXjSQq38+0wox6Rk4KuzkM12QjdscIs4sOKnGzH5OhA
 /V5yYMp16oVXbuqjSA3w2UWQEiBYN6aWtJBKxwkaWulcjHm7FC9NRnSZpxM94ivO8WD7IB5Tk
 TO6LXG28tHaqk54SY8YhsTVGXb6RmisaagZDIdUQlB3e+bcY3zzmQUr7Z3Ngvk9/aEk1tyx2l
 klBx5QMpYeLms5l0hEyzqk9DNfYeWjt4KU+vScP+WwPfVwXd0Rb06Sj/KJTXVxo7IYokLqgzX
 6DL2xb5RvdYIDO9Z7+qtpusYgWEUI7PNbKI9xgxmpMi6oNzEGQHNvsJmCAmHOt5ud3YHUTUNN
 CqYww8kxpQ4hUMCRNozgIM/E5FIw4CZtmyn5i5rRLjJzQLLvilhl5RbSmkaWnlF/5ULUSBkOw
 XJrJxdl4cf5nHa7SjIfiDBUuE0yyqtKPy2cMS8Yysc1c8UxOQr5KR4qi/IyOnTkrmO8KThy3K
 51DedhSeOhV7AeVYHTT0xZZELLitnbUmpckLxUvJX0mVI1faX83Xgje/fc9uV2OGK2d8SfT3N
 4wfS3CtmzLJtihftVb0iI05psSnGR2uqlSyULgCdb7JXHB0iSb8WugT9BKrKo6IwQqapQZSPX
 V1ZXu6w==
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
> Add proper error checking and cleanup for all three ioremap calls in
> the probe function, ensuring that any resources already allocated are
> properly released on failure.

* Please avoid duplicate source code also in the implementation of the fun=
ction =E2=80=9Cplatinumfb_probe=E2=80=9D.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv7.2-rc7#n526

* How do you think about to increase the application of scope-based resour=
ce management?

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n145
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc7#n34


Regards,
Markus
