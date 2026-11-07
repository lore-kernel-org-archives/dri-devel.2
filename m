Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D865606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rJ0aq8s5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1BE10E3F4;
	Sat,  7 Nov 2026 00:19:10 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32DA10E3F4;
 Sat,  7 Nov 2026 00:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794010739; x=1794615539; i=w_armin@gmx.de;
 bh=otalZVWjLLkvOeXJXYnrF0pBbd+DK70KWzAZJaQKjIo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rJ0aq8s5vE2RApmq+Y4Mh5uVe6Z9I9qOJTRdG/Qw3svk1QV305ji3EuuHsf1fT+Q
 5E23nDJJjPYNLrxwk571pPGHPAPysVZpv1HfDv0w+mskch+DCZHGJ6lmiCZ2J58Ul
 uad+r3HVxcrPOuCQNvY76vm8EZqhVp/z6DPxEo0xbzKNoj9k6QpXpHl558b9vHc95
 me63BQzHOeAGSROA8IYr/YpDqVNAropo04dpal6m/Uf3RPQDcmy0zohD5PUICP4wB
 jnVfAhB0C9Y3L9dkYrfiq1P5njiGefVJkedJpl5s6zSEqfzaSMgiyAKXE3Cg4r7aT
 BGg0Wy4AoympXR/QSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1wcLM22bor-00tkPN; Sat, 07
 Nov 2026 01:13:35 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix Kconfig issue with CONFIG_ACPI_WMI
Date: Sat,  7 Nov 2026 01:13:05 +0100
Message-ID: <20261107001330.403365-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kz/uweY1EPr/6BTfQRUVjK3nqaJnGS63fS2XPbI0JLXVdvkt8Rf
 UEJ+dOm6as3THH3oJljf9pJLMTwXFyqAC+n9TPX5khokxu35X9NbWF8yyqkgfIXS9n9Hkt1
 pYQbnGGufkNDVk0QT0qT+qKTCDQYkemQsY4oKRCVbn8atRq19L60xm+p+myK8a/NJ3Mhcsa
 6RasLhwxrhPgYJc5inakQ==
UI-OutboundReport: notjunk:1;M01:P0:Q1KAoZkJ88M=;Wtj+aeaA1mm3SkE4uVXBVOl1JCK
 sar32KtwarSyIg3jFhxnAIt80viQy8+IjsuBm65XJcKKnSevELAEcTjjRpneX4rJx8kcAm2/y
 dRU8TONnhFRTzHcZTiYJnKDekOhJthp39En0KRZzHc5RdRIf0hNsx9CpQw9VmGejaR8CQMQ61
 Y4QSXzD3loz5bw20mhMbvu3KI2ruwiaHCRI+mAyFXEq8odK/hRQFVzgS5XJq4ZjM5vB+9nr/x
 2AexjQ4yieDOwMNoRcwlks0pfFQwXprGn84IypsoD1aqAcwMz+Zr2uqQuCuUTosx1capqYxV8
 brMBiIJZrLobpDdkj/z5xN6PUm+b1QOq65azJ35g1WnjV6ASk1k2rDye5fARNkzBrmyfbkysJ
 x30jr6vJjuj+cehX3WzcCAW1ByHm1AXNLJD9YmwZbsSoj4t9dvwf2feGOvywznuDzj8Z0JXOb
 Wm/Voc0wKt7FR/4qXq/KpeYEuYM7+Slrl6oT/oiY8ZLtxnd3Qw+HQvnxBXfcIAmxKxn1Oh4N/
 h6i2ssWTyBhA2ii+wD5Aq7OhvQDmlHMIzUlX/AyNhDf2QMDp2Noxkas6wDyVu1NRfGv0f5DYW
 Le63jCgOiz8jOsV54CRVwIp3O40CB0A36/a8UQPmnkeYl2rFZBpHdACqSsWJKM+ZiqDS4+AW1
 MbwE01XA48ihjDHiX3OVJbWzhwUKGdLUkzkazL2JRLkH9S8/Hb3BtzV/o2e5gr2J61zepM6Gb
 +bfK+FsNY/jAFemNyD47q0LdGXWabL9IgIiFMTQ39YI7gNH+2rx71ya7SR1kyW4PyjwBP4Ktl
 JU2Rdti0vHvjfqebb+/Cg0YXrcK+REcIpTfwHA+eFwFYxHf01p032LCjRFJDLwioqnoN57GX3
 yxFV9Nfa4mApTjJc9fi2bWVPtAft8wpUW+TFXCAdswiIBwLtNBlY1FxvItDQSUDY2nliN4aEg
 jWl9LSQ8QOcio2Y9rMfoteVJ46GLgrftE9GZDlJlYS8gg65xSN0dEeB1/wUbzGbUl+EEgL9Qy
 DK0syAwUFoduAkdrSNnwwcif4tyXwC8fGtaLuf96arup4ec+gb8t4Wy1kXFh5INSvD00boowP
 WHGefodePLiQkf5fkrs+QOWvfG6v5YyzNIUz0+ylu48jU0IdzqcwM96elNhdYcr1GG2tgkfZY
 9Q0RZOGB5gs/yP8XTHsybVTlyQDiswx/wrnmSWpGKYu4D0fXIrJr1mbmsUiXSutqlgl3RXBGL
 EzUwFRESIUsbMpCSArfyzrX/lKOe6wtfsDCTm7ZR8IwGFlbulsljT0mVjUOauxdPx79lrMK+X
 zHzEZdXDFJizieNRIzxU92rE4oP6ckjyjrLwVcM7jnhH2RdW6WV9PQYPke9PjVw8NaccD8zAn
 BM0IfUdZQVr9olZwz7tnCTNZRjg9K7i1PG2Y/AIrfvaWNP+LIyScn+PVGiH53Y7kItga4gzZV
 N4oCp+Y/xxtLyflXAL/3xTR4lBpqAfFW2Ko5hkRwn8O5uMmO8YkIkbMqURz1Ce0HGe8IkUu0q
 8GhHJkqBaROkY2chLcpYFnFTlesyf7EcYtfF317vhdvy3pMEgrbXrpGydVTKUgP/rS5DAqmaN
 AuhjmLz7luo1DO28N4PLXr1P9eGdAIo2F+z/asIIW0kugsojO4zAOILqq88oU05xQ6zKxRO45
 lCI4DPUts6ClAZOrTwM15DGxX+LH4onS8gg9aS0d7afs3yTvmalbK7DvLWcesob/RH1yZVpdg
 Z8BKy5Aw6IvN/QiRQdOTLK+chfTtiUPBcEEx7UeL9vmtjIOTUMY1V7T5jlwO/3mcc5TesgnWL
 +G439PHITztDBuXlAKd6ssLKaTFSeE3XiCTlfMscg5el4L7437cFWF01kzKw0sdGJuVIw/6Vk
 1/GBjzfoBY2bAGZZMTliFKhWEILDHfY7Fs4jgkfBx0eF5SMBBmlo04VCvdb5yl8fHnmI4e387
 I1tdDCtzme6Pt0EGH8oP3RAVw5gDthAG223JZbWEMks6xmEMo9GGQmCUZ+TWa3yGG7rqt4vLm
 or7EqtZBBEImKUnD2s0zioDg8N0oRl1Oy6e2NeKnsPvywvScoJYU8M83HqYZ1PvcwAI11N+r7
 /AmyJX1BiAUUdkquddexgPL9rL31fPU7WzC5x1bQ2W+9tFJ0iWcLJQ78DHWOIw+XuFb5LOGvG
 wMV8X0Cwz7x4yp4RnxxsxJVxNJCYb6+XMoZkl7ExEj7Pnk+oW8vMcqPwVTZZHAB0xMHfgmnXc
 5ginDA3SCO2kvRhSStTVpdFGyzgXgzkmn33oXkUeWjnuac9RQQEohStAryvnDDBeHORnhm3b8
 uDA8TMOPoJEqCZAqlUN2c5u1EowBkibAPVzp+K/Ri25+Zzkr0krveZuM4mh6O75RV9XjKzXvl
 UaLYw9BLVs3fIq0uIaqXJ+nbHLEaZZFxNnWWGCSsp3bQct51c/zI+V+N2OW0/h7T0ml8GlRRJ
 /ncFiTJ0EA8pQaSW9cmYfxFsPF+8x8zxIzgk+TTd69k4ipintWhb66r8rdC3IpXkL7BN4Mw+7
 2o1lZAGBv/KtVAhi0SZVK4jSjFbuXvU11hsX8OqkvKU60m5CPL40tyiI5zfUAHIrsJMiXnfLv
 msvJfa+N5nH3ehAOXsPgvUWG6MMEUvQLOKae2L2hCPMMTgkeo8HcZ7/80Qvt1b8Aq1apoASJp
 JCR3AjA3pT9fTPw/6mbX+G157i3VnO/NOE6vBUfvLGfTR1NAbGEGymPALLuvE+TtnAT43x9Gs
 Z7xy5etFBNK9Ia9z/yQv3oLU86dHZZqi1T8Mce1T2VfcDwfwwQwyy6ehWphPSbNI6gMsT1EJw
 Y2ypnzhMITITPMvFYO2/9sjZgcwXRN+DRUDjaSd1ZkjBgxkHBqVCFewQM7fMduSwKFW85fFmF
 n4hR/RaRTyxUJH38IehRXqhIIycW1cn2pDJqjpyjttjVJReTqqGFE+FQmjTsK6A1ZNRYgg6DY
 jjEnj3uh9yP+oIWna0tpMq/Mqd58+tCbxMde6aDZTx+L2mtzfUMMsIPcaBZCosO0wOErQlDEF
 MJMR+II/yXTlKWWrJ6v+/0bC5Q9LQwR3bRYtYHtH0Dv6EZGlQ5QL6ZRJwdiewFImwWlHzyTNX
 87UhC9c4gQ1bNJsQgvzkiaWmKpcE7M6M3kAg0MGJqG9S1/WjCnCRspI4ipnisaSSRjqyuQcCt
 yqkmV7goIo/FwFyrB2UUs4FWmFkmIZh+774kH61xscBuJVnC4A1A5QMc+VWZkHYjzMkkOEDM8
 Gf2f/rDImlCr9K8DVXXlNG1dbdesOfFZjVWXQx4QID8feF3wbrbJt5WeDyhBSytiI1wfspyor
 NuTR55d3dQbo4xjSGgV3bcfcn5DgFLn2mrWcto5iCXHG7ss2DMW9BAs0G3WmdupFvoGDns3gy
 pQpHX9qC+xX93mNz60cwcNLejMbGVFtOYe2P855ADfdUtuqR8A8Wc5cfAFFN+POH4x6bN7uEJ
 VGyrJMwjh7jtOhVRIwd2ZiceeW4hpDrwLM4LPRZCFdEaXX74eO6hZ1qQld0kFY0661PD/JyL1
 cNDDb3IRmuvmAEhGy4U1C974BGHxZp5x+38pqjprHeanW2RvTrawg/zOvgYfoGmJmebMPuvUo
 xkpiCIgLF7gy2ufkz7+12zhOSkEXk6EV06JXvdpcMGSIa3zOwFMRqjEab4xfMZIP7HjuIa46G
 4AssjMcdzeDbpGpqoRjrvEKIN4+hfc7pWN7ugPk2RiiEkqqKFlcosXH1wzMGnq5XT4qIpGb89
 5k7QuKerkS/pDhc8biq2zBWSMWd61RhPZI0BGWsNyONdhmTAGOnrtQbhpL17USTGXGCgH3TPl
 8KO1Z9zg/ifbpejIL40flKOfCAT7jPc7sty+eZvMNDLJsuyaqynPDoU4aYX5PsFaL9yHWF/wJ
 MeulzDCLx+MGJftzYb0lggPtMLWKE/xXhZHIgKT9Zd5vbpIFDnLGT8FgQYgAgKVYoIcw8J4H8
 OZDrQw7zG4RbmSwyfq9o5wFEf2uTRQQFvm9BDSGEt/boP7cTVQSzFLkVvBZ+KgHI21WHPVahe
 dSwaVwDlaIc4NVyX6nEH6MtsFgLDozImZtya4jTMDvH8S2ei1dBBcZFbk+elAigSVA/H67fuw
 yNhQlmXyz8VATHhObVNDwUBI3FdFZMjN/hyk3aOMDLjBXmbCPEBdj7+BIXidSmhmGLE+mgFhS
 0ZcwbPGjvCzSmBds6rmHlN+FUzm1jghSdR8Ft3Lp4zdUcETpkU4znsoNKBoyu506xU0UpDfge
 5fZeCua1IwU6eX+tjAdJV+cHY0ROwUlGXZWeoL/Shm2FRCGunaLtiXQ/OYi+x1RUgBOrD3RJH
 vhEwyUqQJnwZ4NGo7bGRABLHU3rCDzVe5gsmA9Tet/3kRpbC4775leg7ijOSNpHWMOsWkD4X7
 UoBveNT1arisrO2cjtEH4tA8zcyat1m0ECA5fBpFmhFWn3/iXVcJ7Cm/GD8TM1u5LY4KXBLvA
 VFriUyPIPmHQl8ooM1hFWxCDIUDmiXmgPxH05Y7qeCjrznMaMswCHcCH0JfOEDwtQKDJACUZj
 L97PxNOtVFLgoaxPV4CJSm31PuGl1pim7qpKueTImg1w1bS2i5gc4IOTF/Dt8uAOUt9HtT7OD
 VJkXqzYnnEgIGyd+YIM8unnS0ZhiaRrWziJKRzb3K0bVvC8jsa2WVK7UTJgd44jqxqbONU9ZC
 YfpUxtvvka1n2TsaIu4LvFKg6jR0kM8k1Qs0hg5njN+Qvzd5H7qc6M/2SpdGPNeNoeKY5hPDb
 JarUUZ13RsBVPQ105oF/cmAKw8qVdeL6SOo9/GCWVJN9qe0b8Kg9kixEbN/ByQEDougbvTsgn
 QyYN6K8dyxRiJfJ6ilHGjrhSoF4RksO1Oz2pv1meRdn9q/RYblFB1oFwWSL1U/2m8MLo5u6K2
 Dv4FA5mk+qjHUatiil4fo3LZZxFAuQcY0s4B7UOSiTGQvdgGhz5aMiSeMSyfv0AqgJ/KTP8Ak
 2DfKj5wH9uHZRlEPf/46V6j4kQ2etgC0eLs7F+bVQOclEvECDY3eopiCpjvLwh1TAv1OSBoe9
 HYrYQTuHXge948klo2oqJ0OGHJj7QuAUUU+YeN8HbSxilST08CFg+9VFpBHMOTq3HjvtbBeEy
 9JzQPdHZFNTIYcz+lxJ4neu7Shsar04f/F5KDBhOpZrRDceGmd5hLCEU/Qm7UXOsI4dhdyJQQ
 4uYQdTc9O7ERziFY4z6OP3EV2wdTFDY8WTfOToY6g94dS+19REI6BsPOWnqbgjYDqZYT2nFaW
 kLP13ZyIKnd3gftp11U2vEo7hmdzixfFsBDf/7A5yHfUEKtmFx0Wadeol02vWWowVmvTiT2wb
 zieX5ads2f9unm6A0mPgerJEGuilZzubd1XAzSm3zoHG2zBE9dU5ibv2SLaorRo5kgavnA6RA
 nqUhWpmP2KPZh1/A00cA1U3nFvywU+zV3ugDPVNyjjEJ3FN9T+zVSBmFJF1SHBc2vqqbGYmlE
 P7eCyFp/geHL8oFDwdSwYiJ4KHxGCrkKokAbLsV9ln7itodDmkIL61R7+oxWyES5mwAto5wrW
 V7cMsVigiueQaQPmFYJEa+/aGdNFg1ui49k1dcxEK4dAyMEa0XmQnJTTMWd3ti4U8LoCUgMv2
 +zwRNbmOEcTIUbhnAeUM7aK88AzqOeXjboEwWOcfwfUz+zncD1CU62fwPi07FARJ2pSa0+TZF
 s8pJ13yRYa2Mbp0nv86/0HQsLSh6F1i46QPFtRaRm4iwaB/siTVb7+r6JgSxEdLAJJ92V52Vn
 A0Sweb8fzYzVBU7Ozobn9kDk+0jCgqon7ILYq3y9oJrp/Y2D2eezpNjWQe5Jk+j6F7QQ+umR/
 AK1dv8aqGLhvDG5Sor+lHN7Et97aZPt75mc7CsMtN7sipdtEKLzeOPQN/Q87PrMpi/xO6Tnie
 Jn31MTxJNQo8GowIqQTpnRTueJq1UoM2SvNxEpjQmK+55PR6evZFHP8ghhd5rlC1dxWAW3dNU
 o7lfnMzxjA0O684Y3ubGFHdpnsxCdtnSAGCR7upCVmNqfyW3GW8cSCq1V3pHnhpAfImbVHBz/
 fI3RBCz4kPk4utIpTfm49T0XCZ6QwPocowmQQOuIpUouSWvif5swKJhcjzO4upC5H+/3RBS1Z
 30X7yIJMQbjVdPSx0GE8Fc/tdOO0B+vvs+zO6GsywLWdwYpyhuXDjDl8EBMfvw6BJSA9nlpUQ
 zrsGwyHh32zuGJjIXWVU6jgqhWQ2UCE6WrDNROE46gNdNLkDf79TKXff2LsTgHCb1yYFSphso
 YAtjcbdCr9TCJmE5ZFBFm5wH6Zw1BP/qACaWxEdzHTUlHUtM8cFtP+GfCgUfmdYpCDKKxm6uh
 n7taRqa0o6UHpGPQ3fWwOmU2+zJzu5WKQGRzCo0Y/x68DTN8XMpa6W+8khJw3ZodrcLnE5xZ4
 ppLos/dVFjjGAKGL6zPTlicJyo0+OVpbDmsqIb2BggaAaANrLwZ3NyH0ZySxK6c502pE50SbV
 2mTMVdo0vnFlrHKXI4yjZJIzGRi+Wid5lsK6ZB4sOAlmmi82FWmQw542dlR5AKutFHPgC8/tI
 sNr3ZwYqM9I/wlAlMTet/xv8m944tmMNgEs7TBbMwpMfCH9RNgc7RUxYYtS5MLqjpZjNk7/yH
 Nx72yB0kRjiMR4NvaVdtFScHd9Ye6aR05Mx0V2iss/ldXisGAo1YhaPQYvDOx2HxmPAXnSnZ1
 /JddKTgYDdE9jGm/vk8CNTDv/IAB+kpEG61kSU8h2V/DSynM0bqN5xROzq9bWiEqzbeTUw2Bw
 nnbQ3JRhSdbs2ag0812Nu3TiXfLPfR1aNSeKdTuCz0+AA==
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nouveau uses wmi_evaluate_method() when CONFIG_ACPI_WMI has been
enabled, but this alone does not guarantee that CONFIG_ACPI_WMI
is actually reachable. If CONFIG_ACPI_WMI is m and CONFIG_DRM_NOUVEAU
is y, said function will not be reachable by nouveau, resulting in
a linker error.

Until now this issue was not triggered because on x86
CONFIG_ACPI_WMI is automatically selected by nouveau. However the
ACPI-WMI subsystem has added support for other ACPI-compatible
architectures like Risc V, making it possible for users to trigger
this bug.

Fix this by always selecting ACPI_WMI if ACPI support is enabled
to ensure that nouveau can actually reach wmi_evaluate_method().

Fixes: 884d53763d30 ("platform/wmi: Remove dependency on CONFIG_X86")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611070038.qzOOv1De-lkp@in=
tel.com/
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kco=
nfig
index 3b5757aed9c8..9c5716738b18 100644
=2D-- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -19,7 +19,7 @@ config DRM_NOUVEAU
 	select I2C_ALGOBIT
 	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
 	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
+	select ACPI_WMI if ACPI
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
=2D-=20
2.56.0

